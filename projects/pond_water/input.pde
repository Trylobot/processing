
void mousePressed() {
  if (mouseButton == LEFT) {
    redraw();
  }
  else if (mouseButton == RIGHT) {
    selectOutput("Save Image", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection != null) {
    saveFrame(selection.getAbsolutePath());
  }
}
