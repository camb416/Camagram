
OverheadView oh;
IsoView iso;
DiaModel diaModel;

void setup() {
  size(1368, 720);
  diaModel = new DiaModel(64,48);
  oh = new OverheadView(diaModel);
  iso = new IsoView(diaModel);
  oh.setup(10,10,320,240);
  iso.setup(340,10, 640, 480, 320);
}
void draw() {
  diaModel.update();
  background(128);
  fill(64);
  noStroke();
  rect(5,5,320+10,height-10);
  iso.draw();
  oh.draw();
}
void mouseMoved() {
  oh.update(mouseX, mouseY);
  //println("h");
}

void mousePressed() {
  oh.click();
}
void mouseDragged() {
  oh.update(mouseX, mouseY);
}
void mouseReleased() {
  oh.unclick();
}

