import java.util.Collections;


float pixels_per_micrometer = 48.0f; // effective zoom
float max_blur_factor = 0.16f; // max blurriness (apparent depth)
float max_blur = max_blur_factor * pixels_per_micrometer;
float[] z_range = { -0.8, 0.8 };

float algae_count = 20;

void setup() {
  size( 800,800 );
  smooth(4);
  noLoop();
  colorMode( HSB, 360,100,100, 1.0 );
}

void draw() {
  
  ///////////////////////////////////
  // Nannochloropsis_Oculata
  ArrayList<Entity> algae = new ArrayList<Entity>();
  for (int i = 0; i < algae_count; ++i) {
    algae.add(new Entity());
  }
  // place algae in the "sample"
  for (Entity e : algae) {
    e.organism = new Nannochloropsis_Oculata();
    e.organism.init( pixels_per_micrometer );
    e.position.set( random(0,width), random(0,height), random(z_range[0], z_range[1]) );
    e.orientation = random(0,TWO_PI);
  }
  // reduce overlap by nudging them around a bit
  algae = handle_collisions( algae );
  
  ///////////////////////////////////
  // debris
  ArrayList<Entity> debris = new ArrayList<Entity>();
  
  
  ///////////////////////////////////
  // merge and sort
  ArrayList<Entity> all_entities = new ArrayList<Entity>();
  all_entities.addAll( algae );
  all_entities.addAll( debris );
  
  // sort into render order by depth (negative = further away)
  Collections.sort( all_entities );
  // set blur as a function of depth (middleground = zero blur)
  //   simulates circle of confusion used in depth of field
  for (Entity e : all_entities) {
    e.blur = max_blur_factor * pixels_per_micrometer * sqrt(abs(e.position.z));
  }
  
  // draw  
  background( color( 251,2,90, 1.0 ));
  // render each organism according to global zoom and organism blur factor
  imageMode( CENTER );
  for (Entity e : all_entities) {
    e.textures = e.organism.render( pixels_per_micrometer, e.blur ); 
  }
  // compose organisms onto final canvas
  for (Entity e : all_entities) {
    for (TextureLayer t : e.textures ) {
      pushMatrix();
      translate( e.position.x,e.position.y );
      //rotate( e.orientation );
      blendMode( t.blend_mode );
      image( t.graphics, 0,0, t.graphics.width,t.graphics.height );
      popMatrix();
    }
  }
  
}
