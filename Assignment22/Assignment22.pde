

void setup() {
  size(800,800);
}

void draw() {
  noStroke();
  background(65, 62, 74);
  
  fill(115,98,110);
  pushMatrix();
  translate(width*0.2, height*0.5);
  rotate(frameCount / 200.0);
  star(0,0, 50, 70, 10);
  popMatrix();
  
  
}

/* Using star function from default examples */
void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

