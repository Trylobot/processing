
// Nannochloropsis Oculata > salt-water photosynthetic algae
//   https://www.nutraingredients-usa.com/Article/2013/09/25/New-algae-omega-3s-player-Qualitas-goes-head-to-head-with-krill
//   https://en.wikipedia.org/wiki/Nannochloropsis

PGraphics Nannochloropsis_Oculata( float scale, int blur ) {
  
  // diameter range of organism, in micrometers
  float[] diameter_range = { 2.0f, 3.0f };
  float wall = 0.025f;
  int organelle_count = 50;

  float diameter = scale * random( diameter_range[0],diameter_range[1] );
  int size = int(2.0f * diameter); // organism content + 50% padding on all sides
  float center = 0.5f * size;
  
  PGraphics g = createGraphics( size,size );
  g.beginDraw();
  g.colorMode( HSB, 360,100,100, 1.0 );
  g.clear();

  // cell interior
  // - base color: circular gradient
  g.noStroke();
  int c0 = color( 69,76,83, 1.0 );
  int c1 = color( 79,75,62, 1.0 );
  int radius = int( 0.5f * diameter );
  for (int i = radius; i > 0; i--) {
    int c = lerpColor( c0,c1, (float(i) / float(radius)) ); 
    g.fill( c );
    g.ellipse( center,center, 2 * i,2 * i );
  }
  // - cell "organelles"
  
  
  // cell wall effects
  g.noFill();
  g.strokeWeight( 6.0f * wall * scale );
  g.stroke( color( 0,0,100, 1.0 ));
  g.ellipse( center,center, diameter,diameter );

  // dark cell wall line
  g.strokeWeight( wall * scale );
  g.stroke( color( 240,100,33, 1.0 ));
  g.ellipse( center,center, diameter,diameter );
  
  // depth of field
  g.filter( BLUR, blur );
  
  g.endDraw();
  
  return g;
}
