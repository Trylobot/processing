void setup() {
   size(400, 400);
   stroke(255);
 }
  
 void draw() {
   line(150, 25, mouseX, mouseY);
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
