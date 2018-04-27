
// Nannochloropsis Oculata > salt-water photosynthetic algae
//   https://www.nutraingredients-usa.com/Article/2013/09/25/New-algae-omega-3s-player-Qualitas-goes-head-to-head-with-krill
//   https://en.wikipedia.org/wiki/Nannochloropsis

int noise_lumpy_radii_x = 0;
int noise_interior_bg_x = 0;
int noise_interior_bg_y = 0;

public class Nannochloropsis_Oculata implements Organism {
  public float diameter;
  
  public void init( float scale ) {
    // diameter of this organism, in micrometers
    diameter = scale * random( 2.0f, 3.0f );
  }
  
  public float collision_radius() {
    return 0.5f * diameter;
  }
  
  public PGraphics render( float scale, int blur ) {
    float wall_thickness = 0.025f;
    int organelle_count = 50;
    
    int size = int(2.0f * diameter); // organism content + 50% padding on all sides
    float center = 0.5f * size;
    
    PGraphics g = createGraphics( size,size );
    g.beginDraw();
    g.colorMode( HSB, 360,100,100, 1.0 );
    g.clear();

    float interior_diameter = diameter - (6.0f * wall_thickness * scale);
    PShape cell = g.createShape();
    cell.beginShape();
    float ang, 
          step = TWO_PI / 180.0f, 
          radius = (0.5f * 1.005f * interior_diameter),
          noisy_radius,
          noise_step = 0.025f;
    for (ang = 0; ang <= TWO_PI; ang += step) {
      noisy_radius = radius - (0.10f * radius * noise(noise_step * float(noise_lumpy_radii_x)));
      noise_lumpy_radii_x += 1; // global
      // noisy radii make the shape look "lumpy"
      cell.vertex(
        noisy_radius * cos(ang),
        noisy_radius * sin(ang) );
    }
    cell.endShape();
    // inner line (dark, but follows "lumpy" contour shape)
    g.noFill();
    g.strokeWeight( 2.0f * wall_thickness * scale );
    g.stroke( color( 240,100,33, 1.0 ));
    g.scale(1.05f);
    g.shape( cell, center,center );
    // cell interior fill, serves as alpha mask for color
    g.noStroke();
    g.fill( color( 0,0,100, 1.0 ));
    g.scale(1f);
    g.shape( cell, center,center );
    ///////////////
    // sample some noise and paint directly onto the graphics buffer
    g.loadPixels();
    int x, y, i, n_x, n_y;
    float r, h, s, v, a;
    PVector p = new PVector();
    for (x = 0; x < g.width; ++x) {
      for (y = 0; y < g.height; ++y) {
        i = x + y*g.width;
        a = alpha(g.pixels[i]);
        if (a > 0) {
          // base
          n_x = x + noise_interior_bg_x;
          n_y = y + noise_interior_bg_y;
          h = 69f + (82f-69f)*noise( x*0.008, y*0.008,  0f );
          s = 70f + (95f-70f)*noise( x*0.010, y*0.010,  5f );
          v = 29f + (90f-29f)*noise( x*0.020, y*0.020, 10f );
          // cell shape overlay
          p.set(x, y);
          r = tan(0.70f + 0.50f*(1.0f - (p.sub(center, center).mag() / (0.5f*diameter))));
          g.pixels[i] = color(
            h, s, r*v, 0.80f*a );
        }
      }
    }
    g.updatePixels();
    noise_interior_bg_x += g.width; // uniqueness of this organism
    noise_interior_bg_y += g.height;

    // cell wall lines
    // outer line (outermost dark line)
    g.noFill();
    g.strokeWeight( wall_thickness * scale );
    g.stroke( color( 240,100,33, 1.0 ));
    g.ellipse( center,center, diameter,diameter );
    // outer line (outermost white line)
    // this is supposed to be a white line but it doesn't seem to have any effect at all
    // could be because of the blend mode in the final composition
    g.noFill();
    g.strokeWeight( 0.25f * wall_thickness * scale );
    g.stroke( color( 240,100,100, 1.0 ));
    g.ellipse( center,center, (wall_thickness * scale) + diameter,(wall_thickness * scale) + diameter );
    
    //// bright donut
    //float blur_factor = 2.0f*float(blur) / (max_blur_factor*pixels_per_micrometer);
    //g.noFill();
    //g.strokeWeight( 2.0f*blur_factor );
    //g.stroke( color( 68, 100, 100, 10.0f*blur_factor ));
    //g.ellipse( center,center, interior_diameter,interior_diameter );
    
    // depth of field
    g.filter( BLUR, blur );
    
    g.endDraw();
    
    return g;
  }
}
