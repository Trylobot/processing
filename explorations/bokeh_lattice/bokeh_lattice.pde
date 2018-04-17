
Circle[] bokehs = new Circle[35];

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 1.0);
  
  generate();  
}

void generate() {
  for (int i = 0; i < bokehs.length; i++) {
    Circle c = new Circle();
    c.c = color(221, 61, 100, 0.2);
    c.p = new PVector(random(0, width), random(0, height));
    c.r = random(20, 250);
    bokehs[i] = c;
  }
}
  
void draw() {
  background(#282C2D);
  
  for (int i = 0; i < bokehs.length; i++) {
    Circle c = bokehs[i];
    noStroke();
    fill(c.c);
    ellipse( c.p.x,c.p.y, c.r,c.r );
  }
}


class Circle {
  public int c;
  public PVector p;
  public float r;
}


//-------------------------

void mousePressed() {
  generate();
}
 
void keyPressed() {
  if (keyCode == ENTER) {
    selectOutput("Save Image", "fileSelected");
  }
}
void fileSelected(File selection) {
  if (selection != null) {
    saveFrame(selection.getAbsolutePath());
  }
}
