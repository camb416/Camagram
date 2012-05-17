class DiaModel {
  ArrayList diaBoxes;
  int xRes;
  int yRes;
  DiaModel(int xRes_in, int yRes_in) {
    xRes = xRes_in;
    yRes = yRes_in;
    diaBoxes = new ArrayList();
  }

  int getNumBoxes() {
    return diaBoxes.size();
  }
  DiaBox getBox(int i) {
    return (DiaBox) diaBoxes.get(i);
  }

  void update() {
    for (int i=0;i<diaBoxes.size();i++) {
      DiaBox b = (DiaBox) diaBoxes.get(i);
      b.update();
    }
  }
  void addBox(float x_in, float y_in, float w_in, float h_in) {
    diaBoxes.add(new DiaBox(x_in, y_in, w_in, h_in));
  }
  int hitTest(float x_in, float y_in) {
    int returnVal = -1;
    for (int i=0;i<getNumBoxes();i++) {
      DiaBox b = getBox(i);
      if (x_in > b.x && x_in < b.x+b.w && y_in > b.y && y_in < b.y+b.h) returnVal = i;
    }
    return returnVal;
  }
}
class DiaBox {
  float x, y, w, h;
  boolean isSelected;
  float z;
  float dZ;
  float time;
  DiaBox(float x_in, float y_in, float w_in, float h_in) {
    x = x_in;
    y = y_in;
    w = w_in;
    h = h_in;
    z = 0.0f;
    dZ = 1.0f;
    time = 0;
    isSelected = false;
  }
  void update() {
   
   // time+=(120.0f-time)/16.0f;
  z += (dZ - z)/16.0f;  
}
  float animPct() {
    if (time > 120) return 1.0f;
    else return time/120.0f;
  }
}

