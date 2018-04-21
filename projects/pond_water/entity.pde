
interface Organism {
  public void init( float scale );  
  public PGraphics render( float scale, int blur );
  public float collision_radius();
}

class Entity implements Comparable<Entity> {
  public Organism organism;
  public PGraphics graphics; // graphics / render-to-texture target
  public PVector position = new PVector(); // position (3D)
  public int blur; // blur amount (due to position.z)
  
  public Entity() {}
  
  public Entity( Entity e ) {
    this.organism = e.organism;
    this.graphics = e.graphics; // reference copy
    this.position.set( e.position );
    this.blur = e.blur;
  }
  
  // natural sort: position.z
  public int compareTo( Entity e ) {
    float diff = this.position.z - e.position.z;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}
