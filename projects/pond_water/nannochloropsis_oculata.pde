
// Nannochloropsis Oculata > salt-water photosynthetic algae
//   https://www.nutraingredients-usa.com/Article/2013/09/25/New-algae-omega-3s-player-Qualitas-goes-head-to-head-with-krill
//   https://en.wikipedia.org/wiki/Nannochloropsis

public class Nannochloropsis_Oculata extends Organism {
  
  // diameter range of organism, in micrometers
  public float[] diameter_range = { 2.0f, 3.0f };
  public float cell_wall_thickness = 0.06f;
  
  // s: scale of destination canvas, in pixels per micrometer
  public void render( float scale, int blur ) {
    float diameter = scale * random( diameter_range[0],diameter_range[1] );
    int size = int(2 * scale * diameter); // organism content + 50% padding
    
    w = size;
    h = size;
    g = createGraphics( w,h );
    g.beginDraw();
    g.colorMode( HSB, 360,100,100, 1.0 );
    g.clear();
    
    g.strokeWeight( cell_wall_thickness * scale );
    g.stroke( color( 240,100,33, 0.5 ));
    g.ellipse( size/2,size/2, diameter,diameter );
    
    g.filter(BLUR, blur);
    
    g.endDraw();
  }
}
