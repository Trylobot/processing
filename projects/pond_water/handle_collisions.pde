
ArrayList<Entity> handle_collisions( ArrayList<Entity> guys ) {
  int count = guys.size();
  
  // clone guys
  ArrayList<Entity> new_guys = new ArrayList<Entity>( count );
  for (Entity e : guys) {
    Entity new_e = new Entity(e);
    new_guys.add(new_e);
  }
  
  // for each guy, map relative positions of all other guys
  for (int i = 0; i < count; ++i) {
    Entity e0 = guys.get(i);
    Entity e1 = new_guys.get(i);
    
    for (int j = 0; j < count; ++j) {
      if (i == j)
        continue; // same guy
      Entity e0_n = guys.get(j);
      // this uses two assumptions from Nannochloropsis_Oculata:
      // 1. organisms are both circular
      // 2. PGraphics created has a padding equal to 50% of organism diameter
      float collide_dist = e0.organism.collision_radius() + e0_n.organism.collision_radius(); 
      PVector diff = PVector.sub( e0.position, e0_n.position );
      float actual_dist = diff.mag();
      if (actual_dist < collide_dist) {
        // circle/circle collision detected
        PVector translation = diff.copy().setMag( diff, 0.5f * (collide_dist - actual_dist));
        e1.position.add( translation );
      }
    }
  }
  
  return new_guys;
}
