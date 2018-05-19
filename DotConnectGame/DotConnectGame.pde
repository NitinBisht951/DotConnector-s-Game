final float RADII = 6;
final byte NROWS = 10;
final byte NCOLS = 10;
final byte NPLAYERS = 2;
final int MAXSCORE = int(NROWS-1)*int(NCOLS-1);

PVector start;
float space;
PFont tFont;
float boxRadii;

SplashScreen splashScreen;
GameManager game;
String[] playersName = {"ANKUR", "NITIN"};
// Bauhaus93-32 Broadway-32 Computerfont-32 GoudyStout-32 Mathematica6-Bold-32

void setup() {
  size(600, 600);
  tFont = loadFont("Computerfont-32.vlw");
  textFont(tFont, 28);
  space = (width-RADII*NCOLS)/(4+NCOLS-1);
  start = new PVector(2*space, 125);
  boxRadii = (space + RADII)/2;
  game = new GameManager();
  splashScreen = new SplashScreen();
}

void draw() {
  background(#500693);
  if (splashScreen.splash == true) {
    splashScreen.splash();
  } else if (game.hasEnded() == false)
    game.run();
  else game.showResult();
}

void mouseClicked() {
  game.mouseClicked();
}

void keyPressed() {
  if(key == ' ' && splashScreen.splash == true) splashScreen.end();
  game.keyPressed();
}

//void mouseMoved() {
//  println(mouseX, mouseY);
//}
