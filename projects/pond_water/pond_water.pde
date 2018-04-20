import java.util.Arrays;


float pixels_per_micrometer = 10.0f; 

int count = 12;
Entity[] guys = new Entity[count];


void setup() {
  size( 800,800 );
  noLoop();
}

void draw() {
  // generate  
  colorMode( HSB, 360,100,100, 1.0 );
  
  for (int i = 0; i < count; ++i) {
    Entity e = new Entity();
    e.organism = new Nannochloropsis_Oculata();
    e.position = new PVector( random(0,width), random(0,height) );
    e.depth = random( -5, 5 );
    guys[i] = e;
  }
  
  Arrays.sort(guys);
  
  // draw  
  background( color( 251,2,90, 1.0 ));
  
  imageMode( CENTER );
  for (int i = 0; i < count; ++i) {
    Entity e = guys[i];
    e.organism.render(
      pixels_per_micrometer, 
      abs(int(e.depth + 0.5f)) );
    image( e.organism.g, 
      e.position.x,e.position.y,
      e.organism.w,e.organism.h );
  }
  
  selectOutput("Save Image", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    saveFrame(selection.getAbsolutePath());
  }
}

//-------------------------

public class Organism {
  public PGraphics g;
  public int w;
  public int h;
  
  void render( float scale, int blur ) {}
}

public class Entity implements Comparable<Entity> {
  public Organism organism;
  public PVector position;
  public float depth; // zero: at focal point, positive: behind focal plane, negative: in front of focal plane
  
  public int compareTo(Entity e) {
    float diff = this.depth - e.depth;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}
