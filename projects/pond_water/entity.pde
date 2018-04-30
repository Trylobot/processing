
class Entity implements Comparable<Entity> {
  // step 1: placement
  public Organism organism;
  public PVector position = new PVector(); // position (3D)
  public float orientation; // angle of orientation
  public float blur; // blur amount (due to position.z)
  // step 2: graphics layers
  public ArrayList<TextureLayer> textures;
  
  
  public Entity() { }
  
  public Entity(Entity other) {
    this.organism = other.organism;
    this.position = other.position.copy();
    this.orientation = other.orientation;
    this.blur = other.blur;
    this.textures = null; // do not copy this; instead, re-render
  }  
  
  // natural sort: position.z
  public int compareTo( Entity e ) {
    float diff = this.position.z - e.position.z;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}

class TextureLayer {
  public PGraphics graphics; // graphics / render-to-texture target
  public int blend_mode; // for blendMode(...)
}

interface Organism {
  public void init( float scale );  
  public float collision_radius();
  public ArrayList<TextureLayer> render( float scale, float blur );
}
  
