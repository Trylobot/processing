import java.util.Collections;

final int Nannochloropsis_Oculata__ID = 100;


void setup() {
  size( 800,800 );
  noLoop();
  colorMode( HSB, 360,100,100, 1.0 );
}

void draw() {
  float pixels_per_micrometer = 48.0f;
  float max_blur_factor = 0.25f;
  int count = 20;
  
  ArrayList<Entity> guys = new ArrayList<Entity>();
  for (int i = 0; i < count; ++i) {
    guys.add(new Entity());
  }
  for (Entity e : guys) {
    e.species = Nannochloropsis_Oculata__ID;
    e.p.set( random(0,width), random(0,height), random(-1,1) );
    e.s = pixels_per_micrometer;
    e.b = int( (max_blur_factor * pixels_per_micrometer)
               * (sqrt(abs(e.p.z)) * Math.signum(e.p.z)) );
  }
  Collections.sort(guys);
  
  // draw  
  background( color( 251,2,90, 1.0 ));
  
  imageMode( CENTER );
  for (Entity e : guys) {
    switch (e.species) {
      case Nannochloropsis_Oculata__ID:
        e.g = Nannochloropsis_Oculata( e.s, e.b ); break; 
    }
  }
  // each organism determines its own size from a range
  // reduce overlap by nudging them around a bit
  guys = handle_collisions( guys );
  //
  for (Entity e : guys) {
    pushMatrix();
    tint( 255, 0.50f + (0.15f - (0.15f * e.p.z)) );
    translate( e.p.x,e.p.y );
    rotate( random( 0, TWO_PI ));
    image( e.g, 0,0, e.g.width,e.g.height );
    popMatrix();
  }
  
}
