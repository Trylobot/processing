import java.util.Arrays;

int node_count = 48;
int edges_per_node = 5;
float blur_chance = 0.20f;
float[] blur_range = {0.0f, 2.0f};

Node[] nodes;
ArrayList<Edge> edges;


void setup() {
  size(800, 600);
  generate();
}

void generate() {

  colorMode(HSB, 360, 100, 100, 1.0);

  // bokeh
  nodes = new Node[node_count];
  for (int i = 0; i < node_count; i++) {
    Node n = new Node();
    n.c = color(221, 61, 100, 0.2);
    n.p = new PVector(random(0, width), random(0, height));
    n.r = random(width/400f, width/3.2f);
    n.b = 0.0f;
    if (random(0,1) < blur_chance) {
      n.b = random(blur_range[0], blur_range[1]);
    }
    nodes[i] = n;
  }

  // lattice
  edges = new ArrayList<Edge>();
  for (int i = 0; i < node_count; i++) {
    Edge[] others = new Edge[node_count];
    for (int j = 0; j < node_count; j++) {
      Edge e = new Edge();
      e.n0 = nodes[i];
      e.n1 = nodes[j];
      e.d = PVector.dist(e.n0.p, e.n1.p);
      others[j] = e;
    }
    Arrays.sort(others);
    for (int k = 1; k <= edges_per_node; k++) {
      edges.add(others[k]);
    }
  }
}

class Node {
  public int c; // color
  public PVector p; // position
  public float r; // radius
  public float b; // blur amount (affects all previous)
}

class Edge implements Comparable<Edge>{
  public Node n0;
  public Node n1;
  public float d; // distance
  
  public int compareTo(Edge e) {
    float diff = this.d - e.d;
    if (diff < 0) return -1;
    else if (diff > 0) return 1;
    else return 0;
  }
}

void draw() {
  background(#282C2D);

  // bokeh
  for (Node n : nodes) {
    noStroke();
    fill( n.c );
    ellipse( n.p.x, n.p.y, n.r, n.r );
    if (n.b > 0.0f) {
      filter(BLUR, n.b);
    }
  }

  // lattice
  for (Edge e : edges) {
    strokeWeight(0.5);
    stroke(#FFFFFF,0.5);
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
