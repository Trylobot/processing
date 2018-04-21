
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
    //int organelle_count = 50;
  
    int size = int(2.0f * diameter); // organism content + 50% padding on all sides
    float center = 0.5f * size;
    
    PGraphics g = createGraphics( size,size );
    g.beginDraw();
    g.colorMode( HSB, 360,100,100, 1.0 );
    g.clear();
  
    // dark cell wall line
    g.noFill();
    g.strokeWeight( wall_thickness * scale );
    g.stroke( color( 240,100,33, 1.0 ));
    g.ellipse( center,center, diameter,diameter );
    
    // cell interior
    // - base color: circular gradient
    g.noStroke();
    int c0 = color( 69,76,83, 1.0 );
    int c1 = color( 79,75,62, 1.0 );
    int radius = int( 0.5f * diameter - (3.0f * wall_thickness * scale ));
    for (int i = radius; i > 0; i--) {
      int c = lerpColor( c0,c1, (float(i) / float(radius)) ); 
      g.fill( c );
      g.ellipse( center,center, 2 * i,2 * i );
    }
    // - cell "organelles"
    
    
    // depth of field
    g.filter( BLUR, blur );
    
    g.endDraw();
    
    return g;
  }
}
