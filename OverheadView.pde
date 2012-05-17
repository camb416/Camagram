class OverheadView {

  int x, y, w, h;  
  float cx, cy;
  float cox, coy;
  DiaModel diaModel;
  
  int selectedBox = -1;

  OverheadView(DiaModel diaModel_in) {
    diaModel = diaModel_in;
  }

  void setup(int x_in, int y_in, int w_in, int h_in) {
    x = x_in;
    y = y_in;
    w = w_in;
    h = h_in;
    cx = -1;
    cy = -1;
    cox = coy = -1;
  } 
  void update(int mx, int my) {
    if (mx>x && mx<x+w && my>y && my<y+h) {
      cx = ((mx-x)/(float)w*(float)diaModel.xRes)/(float)diaModel.xRes;
      cy = ((my-y)/(float)h*(float)diaModel.yRes)/(float)diaModel.yRes;
      // println("b");
  selectedBox = diaModel.hitTest(cx,cy);
 if(selectedBox>-1){
  cx = cy = cox = coy = -1;
   
 } else {
      cx = round((mx-x)/(float)w*(float)diaModel.xRes)/(float)diaModel.xRes;
      cy = round((my-y)/(float)h*(float)diaModel.yRes)/(float)diaModel.yRes;
 }
  } 
    else {
      cx = -1;
      cy = -1;
    }
    for(int i=0;i<diaModel.getNumBoxes();i++){
      DiaBox b = diaModel.getBox(i);
    b.isSelected = (i==selectedBox);
    }
  }


  void click() {
    println(selectedBox);
   if(selectedBox>-1){
     DiaBox b = diaModel.getBox(selectedBox);
     b.dZ++;
   } else if (cx>-1 && cy>-1) {
      cox = cx;
      coy = cy;
    }
  }
  void unclick() {
    if (cx>-1 && cy>-1 && cox > -1 && coy > -1) {
      diaModel.addBox(cox, coy, cx-cox, cy-coy);
    } 
    else {
      cox = -1;
      coy = -1;
    }
  }

  void draw() {
    // println(cx+", "+cy);
    stroke(0);
    fill(255);
    rect(x, y, w, h);
    noFill();
    stroke(128);
    for (int j=0;j<(float)diaModel.yRes;j++) {
      line(x, y+j*w/(float)diaModel.xRes, x+w, y+j*h/(float)diaModel.yRes);
    }
    for (int i=0;i<(float)diaModel.xRes;i++) {
      line(x+i*w/(float)diaModel.xRes, y, x+i*h/(float)diaModel.yRes, y+h);
    }
    
    if (cox>-1 && coy>-1) {

      noStroke();
      fill(255, 0, 0);
      ellipse(x+cox*w, y+coy*h, 5, 5);
    }

    for (int i=0;i<diaModel.diaBoxes.size();i++) {
      fill(0);
      noStroke();
      DiaBox b = (DiaBox) diaModel.diaBoxes.get(i);
      
      //fill(212);
      //rect(x+(b.x-1.0f/(float)diaModel.xRes)*w, y+(b.y-1.0f/(float)diaModel.yRes)*h, (b.w+1.0f/(float)diaModel.xRes*2)*w, (b.h+1.0f/(float)diaModel.yRes*2)*h);
      if(b.isSelected){
       fill(128,64,32); 
      } else {
        fill(64);
      }
      rect(x+b.x*w, y+b.y*h, b.w*w, b.h*h);
      
      
    }
    if (cx>-1 && cy>-1) {

      noStroke();
      fill(0,0,255);
      ellipse(x+cx*(float)w, y+cy*(float)h, 5, 5);
    }
  }
}

