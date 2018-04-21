
public class Entity implements Comparable<Entity> {
  public int species;
  public PGraphics g; // graphics / render-to-texture target
  public PVector p = new PVector(); // position (3D)
  public float s; // scale (pixels per micrometer)
  public int b; // blur amount (due to position.z)
  
  public Entity() {}
  
  public Entity( Entity e ) {
    this.species = e.species;
    this.g = e.g; // reference copy
    this.p.set( e.p );
    this.s = e.s;
    this.b = e.b;
  }
  
  // natural sort: position.z
  public int compareTo( Entity e ) {
    float diff = this.p.z - e.p.z;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}
