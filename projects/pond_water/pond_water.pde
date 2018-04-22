import java.util.Collections;


void setup() {
  size( 800,800 );
  noLoop();
  colorMode( HSB, 360,100,100, 1.0 );
}

void draw() {
  float pixels_per_micrometer = 48.0f; // effective zoom
  float max_blur_factor = 0.20f; // max blurriness (apparent depth)
  int count = 20;
  
  ArrayList<Entity> guys = new ArrayList<Entity>();
  for (int i = 0; i < count; ++i) {
    guys.add(new Entity());
  }
  // choose random initial positions for a bunch of organisms
  for (Entity e : guys) {
    e.organism = new Nannochloropsis_Oculata();
    e.organism.init( pixels_per_micrometer );
    e.position.set( random(0,width), random(0,height), random(-1,1) );
  }
  // reduce overlap by nudging them around a bit
  guys = handle_collisions( guys );
  // sort into render order by depth (negative = further away)
  Collections.sort(guys);
  // set blur as a function of depth (middleground = zero blur)
  //   simulates circle of confusion used in depth of field
  for (Entity e : guys) {
    e.blur = int((max_blur_factor * pixels_per_micrometer)
                 * (sqrt(abs(e.position.z)) * Math.signum(e.position.z)) );
  }
  
  // draw  
  background( color( 251,2,90, 1.0 ));
  // render each organism according to global zoom and organism blur factor
  imageMode( CENTER );
  for (Entity e : guys) {
    e.graphics = e.organism.render( pixels_per_micrometer, e.blur ); 
  }
  // compose organisms onto final canvas
  for (Entity e : guys) {
    pushMatrix();
    //tint( 255, 10 ); // + (0.15f - (0.15f * e.p.z)) );
    blendMode(DARKEST);
    translate( e.position.x,e.position.y );
    rotate( random( 0, TWO_PI ));
    image( e.graphics, 0,0, e.graphics.width,e.graphics.height );
    popMatrix();
  }
  
}
