int nFramesInLoop = 30; //Change to 10 for lenticular
int nElapsedFrames;
boolean bRecording;

//The current frame we're on
int currentFrame;

void setup() {
  size(1000,1000);
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop);
  currentFrame = 0;
}

void keyPressed() {
  //Press a key to export frames to the output folder
  bRecording = true;
  nElapsedFrames = 0;
}

void draw() {
  
  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } 
  else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
  
  // Render the design, based on that percentage. 
  renderDesign (percentCompleteFraction);
 
  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    String  myName = "sylviakosowski"; 
    saveFrame("output/"+ myName + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == nFramesInLoop) {
      bRecording = false;
    }
  }
  
}

//Create the design
void renderDesign (float percent) {
  noStroke();
  background(65, 62, 74);

  /* top left dark pink wheel */
  wheel(300, 150, 159, 109, 112, 200, 170, 100, 8, percent, 14);
  
  /* center smaller wheel */
  wheel(500, 150, 179, 129, 132, 140, 120, 70, 5, percent, 10);
  
  /* right top wheel */
  wheel(690, 150, 95, 78, 90, 200, 170, 100, 4, percent,14);
  
  fill(115,98,110);
  rect(200,120,700,25);
  
  /* center top darker purple gray gear */
  gear(95, 78, 90, 220, 130, 60, 70, 15, 20, (float) nFramesInLoop);
  
  /*left top small pale purple really spikey jagged */
  gear(115,98, 110, 300, 140, 40, 60, 20, 10, -(float) nFramesInLoop);
  
  /*Lefttop large pink ultraspiky */
  gear(179, 129, 132, 200, 200, 90, 100, 20, 40, -(float) nFramesInLoop);
  
  /*Left top small spiky gear*/
  gear(115, 98, 110, 150, 150, 50, 70, 10, 20, (float) nFramesInLoop);
  
  /* center top darker purple gray gear */
  gear(95, 78, 90, 400, 120, 60, 70, 15, 20, -(float) nFramesInLoop);
  
  /* right large pink */
  gear(159, 109, 112, 800, 150, 100, 110, 20, 40, (float) nFramesInLoop);
  
  /* center dark pink */
  gear(159, 109, 112, 600, 150, 50, 60, 12, 10, -(float) nFramesInLoop);
  
  /* right small pink 4 */
  gear(179,129,132, 690, 150, 20, 60, 4, 10, -(float) nFramesInLoop);
  
}

void gear(int c1, int c2, int c3, int x, int y, float radius1, float radius2, int nPoints,
  int centerRadius, float rate) {
  pushMatrix();
  translate(x, y);
  rotate(frameCount / rate);
  fill(c1,c2,c3);
  star(0,0, radius1, radius2, nPoints);
  fill(65,62,74);
  ellipse(0,0,centerRadius, centerRadius);
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

//Make a wheel, specifying color, radius, and number of 
void wheel(int x, int y, int c1, int c2, int c3, int outerRadius, int innerRadius, 
  int spokeRadius, int numSpokes, float percent, int weight) {
  /*Wheel*/
  fill(c1,c2,c3);
  ellipse(x, y, outerRadius, outerRadius);
  fill(65, 62, 74);
  ellipse(x, y, innerRadius, innerRadius);
  
  //Using Golan's sample code
  float radius = spokeRadius; 
  for (int i=0; i < numSpokes; i++) {
    float armAngle = (percent + i) * (TWO_PI/numSpokes); 
    float px = x + radius*cos(armAngle); 
    float py = y + radius*sin(armAngle); 
    //fill    (255); 
    stroke(c1,c2,c3);
    strokeWeight(weight);
    line    (x, y, px, py); 
    noStroke();
    //ellipse (px, py, 20, 20);
  }
}

