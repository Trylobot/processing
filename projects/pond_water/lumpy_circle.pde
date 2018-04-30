PShape lumpy_circle(
  PGraphics g,
  float radius,
  float lumpiness, // [0, 1]
  int vertices,
  float noise_step,
  float noise_offset)
{
  PShape shape = g.createShape();
  shape.beginShape();
  float a, cos_a, sin_a, r;
  float step = TWO_PI / float(vertices);
  for (a = 0f; a < TWO_PI; a += step) {
    cos_a = cos(a);
    sin_a = sin(a);
    // noise(x,y) moves in lockstep with the actual vertex coordinates to ensure visual continuity 
    r = radius - (radius * lumpiness *
      noise(
        (cos_a * noise_step) + noise_offset, 
        (sin_a * noise_step) + noise_offset ));
    // noisey, continuous magnitude is then applied to the unit circle vectors making up the shape
    shape.vertex( r * cos(a), r * sin(a) );
  }
  shape.endShape();
  return shape;
}
