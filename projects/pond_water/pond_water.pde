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
    e.position = new PVector( random(0,width), random(0,height) );
    e.scale = pixels_per_micrometer;
    e.z = random(-1,1);
    e.blur = int( 
      (max_blur_factor * pixels_per_micrometer) * 
      (sqrt(abs(e.z)) * Math.signum(e.z)) );
  }
  Collections.sort(guys);
  
  // reduce entity overlap
  //nudge( guys );
  
  // draw  
  background( color( 251,2,90, 1.0 ));
  
  // this project simulates a light microscope; each organism absorbs some of the light
  imageMode( CENTER );
  for (Entity e : guys) {
    switch (e.species) {
      case Nannochloropsis_Oculata__ID:
        e.g = Nannochloropsis_Oculata( e.scale, e.blur ); break; 
    }
  }
  for (Entity e : guys) {
    pushMatrix();
    tint( 255, 0.50f + (0.15f - (0.15f * e.z)) );
    translate( e.position.x,e.position.y );
    rotate( random( 0, TWO_PI ));
    image( e.g, 0,0, e.g.width,e.g.height );
    popMatrix();
  }
  
}

void mousePressed() {
  if (mouseButton == LEFT) {
    redraw();
  }
  else if (mouseButton == RIGHT) {
    selectOutput("Save Image", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection != null) {
    saveFrame(selection.getAbsolutePath());
  }
}

//-------------------------

public class Entity implements Comparable<Entity> {
  public int species;
  public PGraphics g;
  public PVector position;
  public float scale;
  public float z;
  public int blur;
  
  public int compareTo(Entity e) {
    float diff = this.z - e.z;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}
