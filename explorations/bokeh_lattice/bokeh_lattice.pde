
int node_count = 35;
int edges_per_node = 2;

Node[] nodes = new Node[node_count];
ArrayList<Edge> edges = new ArrayList<Edge>();


void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 1.0);

  generate();
}

void generate() {

  // bokeh
  for (int i = 0; i < node_count; i++) {
    Node n = new Node();
    n.c = color(221, 61, 100, 0.2);
    n.p = new PVector(random(0, width), random(0, height));
    n.r = random(20, 250);
    nodes[i] = n;
  }

  // lattice
  edges.clear();
  for (int i = 0; i < node_count; i++) {
    for (int j = 0; j < node_count; j++) {
      Edge e = new Edge();
      e.n0 = nodes[i];
      e.n1 = nodes[j];
      e.d = PVector.dist(e.n0.p, e.n1.p);
      edges.add(e);
    }
  }
}

class Node {
  public int c;
  public PVector p;
  public float r;
}

class Edge {
  public Node n0;
  public Node n1;
  public float d;
}

void draw() {
  background(#282C2D);

  // bokeh
  for (Node n : nodes) {
    noStroke();
    fill( n.c );
    ellipse( n.p.x, n.p.y, n.r, n.r );
  }

  // lattice
  for (Edge e : edges) {
    stroke(#FFFFFF);
    noFill();
    line( e.n0.p.x,e.n0.p.y, e.n1.p.x,e.n1.p.y );
  }
  
  // ---------------------
  if (save_path != null) {
    saveFrame(save_path);
    save_path = null;
  }
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
    save_path = selection.getAbsolutePath();
  }
}
String save_path = null;
