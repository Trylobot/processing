
// Nannochloropsis Oculata > salt-water photosynthetic algae
//   https://www.nutraingredients-usa.com/Article/2013/09/25/New-algae-omega-3s-player-Qualitas-goes-head-to-head-with-krill
//   https://en.wikipedia.org/wiki/Nannochloropsis

public class Nannochloropsis_Oculata implements Organism {
  public float diameter;
  
  public void init( float scale ) {
    // diameter of this organism, in micrometers
    diameter = scale * random( 2.0f, 3.0f );
  }
  
  public float collision_radius() {
    return 0.5f * diameter;
  }
  
  public ArrayList<TextureLayer> render( float scale, float blur ) {
    float blur_factor = (blur / max_blur);
    int size = int(2.0f * diameter); // organism content + 50% padding on all sides
    float center = 0.5f * size;
    float wall_thickness = 0.025f;
    
    ArrayList<TextureLayer> textures = new ArrayList<TextureLayer>(2);

    TextureLayer base = new TextureLayer();
    textures.add( base );
    base.blend_mode = DARKEST;
    PGraphics bg = createGraphics( size,size );
    base.graphics = bg;
    
    bg.beginDraw();
    bg.colorMode( HSB, 360,100,100, 1.0 );
    bg.ellipseMode( CENTER );
    bg.clear();
    bg.translate( center,center );

    float interior_diameter = diameter - (6.0f * wall_thickness * scale);
    ///////////
    PShape cell = lumpy_circle( bg, 
      (0.5f * 1.005f * interior_diameter), // radius
      0.12f, // lumpiness factor
      90, // vertices
      1.5f, // noise step
      (blur * size) ); // noise offset
    ///////////
    // inner line (dark, but follows "lumpy" contour shape)
    bg.noFill();
    bg.strokeWeight( 6.0f * wall_thickness * scale );
    bg.stroke( color( 240,100,33, 1.0 ));
    bg.scale(1.05f);
    bg.shape( cell, 0,0 );
    // cell interior fill, serves as alpha mask for color
    bg.noStroke();
    bg.fill( color( 0,0,100, 1.0 ));
    bg.scale(1f);
    bg.shape( cell, 0,0 );
    ///////////////
    // sample some noise and paint directly onto the graphics buffer
    bg.loadPixels();
    int x, y, i, n_x, n_y;
    float r, h, s, v, a;
    PVector p = new PVector();
    for (x = 0; x < bg.width; ++x) {
      for (y = 0; y < bg.height; ++y) {
        i = x + y*bg.width;
        a = alpha(bg.pixels[i]);
        if (a > 0) {
          // base
          n_x = x + int(blur * size);
          n_y = y + int(blur * size);
          h = 69f + (82f-69f)*noise( n_x*0.008, n_y*0.008,  0f );
          s = 70f + (95f-70f)*noise( n_x*0.010, n_y*0.010,  5f );
          v = 29f + (90f-29f)*noise( n_x*0.020, n_y*0.020, 10f );
          // cell shape overlay
          p.set(x, y);
          r = tan(0.70f + 0.50f*(1.0f - (p.sub(center, center).mag() / (0.5f*diameter))));
          bg.pixels[i] = color(
            h, s, r*v, 0.80f*a );
        }
      }
    }
    bg.updatePixels();

    // cell wall lines
    // outer line (outermost dark line)
    bg.noFill();
    bg.strokeWeight( wall_thickness * scale );
    bg.stroke( color( 240,100,33, 1.0 ));
    bg.ellipse( 0,0, diameter,diameter );
    
    // circle of confusion / depth of field, simulated
    bg.filter( BLUR, blur );
    
    bg.endDraw();
    
    //////////////////////////////////////////////////////////////
    // "bright donut" layer (most visible when out of focus)
    TextureLayer fore = new TextureLayer();
    textures.add( fore );
    
    fore.blend_mode = LIGHTEST;
    PGraphics fg = createGraphics( size,size );
    fore.graphics = fg;
    
    fg.beginDraw();
    fg.colorMode( HSB, 360,100,100, 1.0 );
    fg.ellipseMode( CENTER );
    fg.clear();
    fg.translate( center,center );
  
    float donut_thickness = (0.08f * diameter) + (0.16f * blur_factor * diameter);
    float alpha = 0.40f + (0.30f * blur_factor);
    float d = interior_diameter - (0.5f * donut_thickness);
    fg.noFill();
    fg.strokeWeight( donut_thickness );
    fg.stroke( color( 68,100,100, alpha ));
    fg.ellipse( 0,0, d,d );
    fg.filter( BLUR, (3f * blur_factor) );
    fg.filter( BLUR, (3f * blur_factor) );
    fg.endDraw();
    
    return textures;
  }
}
