int nFramesInLoop = 10; //Change to 10 for lenticular
int nElapsedFrames;
boolean bRecording;

//The current frame we're on
int currentFrame;
int moonTranslate;
int moonStep;

void setup() {
  size(1000,1000);
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop);
  currentFrame = 0;
  moonTranslate = 540;
  moonStep = 2;
}

void keyPressed() {
  //Press a key to export frames to the output folder
  bRecording = true;
  nElapsedFrames = 0;
}

void draw() {
  
  pushMatrix();
  //scale(1.5, 1.5); //used for rescaling the composition size
  
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
  
  popMatrix();
  
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
  
  hangingStar(150, 350, 20, 40, 220, -percent);
  hangingStar(400, 420, 20, 40, 300, percent);
  hangingStar(700, 350, 20, 40, 250, -percent);
  
  moon();
  
  allGears(percent);
}

void moon() {
   /*moon*/
  fill(179, 129, 132);
  rect(580, 120, 5, 200);
  rect(600, 120, 5, 200);
  
  fill(240, 180, 158);
  ellipse(580, 320, 70, 70);
  
  pushMatrix();
  fill(65, 62, 74);
  
  if( moonTranslate > 550) {
    moonStep *= -1;
  }
  
  if( moonTranslate < 540) {
    moonStep *= -1;
  }
  moonTranslate += moonStep;
  translate(moonTranslate + moonStep, 320);
  
 // print(changeMoon);
  //translate(moonTranslate + changeMoon*2*frameCount,320);
  ellipse(0, 0, 70, 70);
  popMatrix();
}



void allGears(float percent) {
  
   /* center top darker purple gray gear */
  gear(95, 78, 90, 220, 130, 60, 70, 15, 20, percent);
  
  /*left top small pale purple really spikey jagged */
  gear(115,98, 110, 300, 140, 40, 60, 20, 10, percent);
  
  /*Lefttop large pink ultraspiky */
  gear(179, 129, 132, 200, 200, 90, 100, 20, 40, -percent);
  
  /*Left top small spiky gear*/
  gear(115, 98, 110, 150, 150, 50, 70, 10, 20, percent);
  
  /* center top darker purple gray gear */
  gear(95, 78, 90, 400, 120, 60, 70, 15, 20, -percent);
  
  /* light purple right behind large pink */
  gear(115, 98, 110, 700, 120, 40, 60, 14, 20, percent);
  
  /* right top bottom light pink */
  gear(179,129,132, 820, 230, 50, 60, 10, 10, -percent);
  
  /* right large pink */
  gear(159, 109, 112, 800, 150, 100, 110, 20, 40, percent);
  
  /* center dark pink */
  gear(159, 109, 112, 600, 150, 50, 60, 12, 10, -percent);
  
  /* right small pink 4 */
  gear(179,129,132, 690, 150, 20, 60, 4, 10, -percent);
  
}

void hangingStar(int x, int y, int r1, int r2, int stringLength, float rate) {
  
  fill(179, 129, 132);
  rect(x-10, 120, 5, stringLength);
  rect(x+10, 120, 5, stringLength);
  gear(247, 228, 190, x, y, r1, r2, 5, 0, rate);
  
}

void gear(int c1, int c2, int c3, int x, int y, float radius1, float radius2, int nPoints,
  int centerRadius, float rate) {
  pushMatrix();
  translate(x, y);
  //rotate(frameCount / rate);
  rotate(rate * TWO_PI / nPoints );
  fill(c1,c2,c3);
  star(0,0, radius1, radius2, nPoints, rate);
  fill(65,62,74);
  ellipse(0,0,centerRadius, centerRadius);
  popMatrix();
}

/* Using star function from default examples */
void star(float x, float y, float radius1, float radius2, int npoints, float percent) {
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

//Make a wheel, specifying color, radius, and number of spokes
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
    stroke(c1,c2,c3);
    strokeWeight(weight);
    line    (x, y, px, py); 
    noStroke();
  }
}

