class IsoView {



  DiaModel diaModel;
  int x, y, w, h;  
  float offset;

  IsoView(DiaModel diaModel_in) {
    diaModel = diaModel_in;
  }

  void setup(int x_in, int y_in, int w_in, int h_in, float offset_in) {
    x = x_in;
    y = y_in;
    w = w_in;
    h = h_in;
    offset = offset_in;
  }
  void draw() {

    pushMatrix();
    translate(x, y);

    // draw grid
    stroke(140);
    // horizontals
    for (int j=0;j<(float)diaModel.yRes;j++) {
      line(j/(float)diaModel.yRes*offset,j/(float)diaModel.yRes*h,j/(float)diaModel.yRes*offset+w,j/(float)diaModel.yRes*h);
    }
    //verticals
    for (int i=0;i<(float)diaModel.xRes;i++) {
      line(i*w/(float)diaModel.xRes, 0, i*w/(float)diaModel.xRes+offset, h);
    }
    
    
    
    // outline
    noFill();
    stroke(255);
    beginShape();
    vertex(0, 0);
    vertex(w, 0);
    vertex((w)+offset, h);
    vertex(offset, h);
    vertex(0, 0);
    endShape();
    

    int numBoxes = diaModel.getNumBoxes();
    fill(255);
    stroke(0);
    for (int j=0;j<5;j++) {
      for (int i=0;i<numBoxes;i++) {
        DiaBox b = diaModel.getBox(i);
        drawWall(b, j);
      }
    }
    /*
      // bottom
     beginShape();
     vertex(b.x*w+b.y*offset, b.y*h); // top left
     vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom left
     vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom right
     vertex((b.x*w+b.w*w)+b.y*offset, b.y*h); // top right
     vertex(b.x*w+b.y*offset, b.y*h); // top left
     endShape();
     */
















    // rect(b.x*w,b.y*h,b.w*w,b.h*h);

    popMatrix();
  }
  void drawWall(DiaBox b, int whichWall) {
    noStroke();
    switch(whichWall) {
    case 0:
      fill(96);
      // back wall
      beginShape();
      vertex(b.x*w+b.y*offset, b.y*h); // top left
      vertex(b.x*w+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top left extruded
      vertex((b.x*w+b.w*w)+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top right extruded
      vertex((b.x*w+b.w*w)+b.y*offset, b.y*h); // top right
      vertex(b.x*w+b.y*offset, b.y*h); // top left
      endShape();

      break;
    case 1:
      fill(96);
      // right wall
      beginShape();

      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom right
      vertex((b.x*w+b.w*w)+b.y*offset, b.y*h); // top right
      vertex((b.x*w+b.w*w)+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top right extruded
      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom right extruded
      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom right

      endShape();
      break;
    case 2:
      fill(96);
      // left wall
      beginShape();
      vertex(b.x*w+b.y*offset, b.y*h); // top left
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom left
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom left extruded
      vertex(b.x*w+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top left extruded
      vertex(b.x*w+b.y*offset, b.y*h); // top left
      endShape();

      break;
    case 3:
      fill(192);
      // front wall
      beginShape();
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom left
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom left extruded
      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom right extruded
      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom right
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h); // bottom left
      endShape();
      break;
    case 4:
      // top
      fill(255);
      beginShape();
      vertex(b.x*w+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top left extruded
      vertex(b.x*w+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom left extruded
      vertex((b.x*w+b.w*w)+(b.y+b.h)*offset, b.y*h+b.h*h-h/(float)diaModel.yRes*b.z); // bottom right extruded
      vertex((b.x*w+b.w*w)+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top right extruded
      vertex(b.x*w+b.y*offset, b.y*h-h/(float)diaModel.yRes*b.z); // top left extruded
      endShape();
    }
  }
}

