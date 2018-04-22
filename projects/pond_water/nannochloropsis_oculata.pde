
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
  
  public PGraphics render( float scale, int blur ) {
    float wall_thickness = 0.025f;
    int organelle_count = 50;
    
    int size = int(2.0f * diameter); // organism content + 50% padding on all sides
    float center = 0.5f * size;
    
    PGraphics g = createGraphics( size,size );
    g.beginDraw();
    g.colorMode( HSB, 360,100,100, 1.0 );
    g.clear();

    // cell interior
    float interior_diameter = diameter - (6.0f * wall_thickness * scale);
    g.noStroke();
    g.fill( color( 0,0,100, 1.0 ));
    g.ellipse( center,center, interior_diameter,interior_diameter );
    g.loadPixels();
    // sample some noise
    for (int x = 0; x < g.width; ++x) {
      for (int y = 0; y < g.height; ++y) {
        int i = x + y*g.width;
        float a = alpha(g.pixels[i]);
        if (a > 0) {
          g.pixels[i] = color(
            69f + ((82f-69f)*noise( x*0.008, y*0.008,  0f )),
            70f + ((95f-70f)*noise( x*0.010, y*0.010,  5f )),
            29f + ((90f-29f)*noise( x*0.020, y*0.020, 10f )),
            a );
        }
      }
    }
    g.updatePixels();

    // cell wall
    g.noFill();
    g.strokeWeight( wall_thickness * scale );
    g.stroke( color( 240,100,33, 1.0 ));
    g.ellipse( center,center, diameter,diameter );
    
    // depth of field
    g.filter( BLUR, blur );
    
    g.endDraw();
    
    return g;
  }
}
