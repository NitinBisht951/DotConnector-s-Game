final float RADII = 6;              // 10 for mobile, 6 for PC
final byte NROWS = 9;              // 8 for mobile, 9 for PC
final byte NCOLS = 10;              // 6  for mobile, 10 for PC
final byte NPLAYERS = 2;
final int MAXSCORE = int(NROWS-1)*int(NCOLS-1);

PVector start;
float space;
PFont scoreFont, initialsFont;
float boxRadii;

GameManager game;
String[] playersName = {"ANKUR", "NITIN"};
// BookmanOldStyle-Bold-32

void setup() {
  //fullScreen();
  size(600, 600);         // size(displayWidth, displayHeight) for mobile, size(600, 600) for PC
  strokeCap(SQUARE);
  scoreFont = loadFont("BookmanOldStyle-Bold-32.vlw");
  initialsFont = loadFont("BookmanOldStyle-Bold-32.vlw");
  textFont(scoreFont, 32);                // 40 for mobile, 32 for PC
  space = (width-RADII*NCOLS)/(2+NCOLS-1);
  start = new PVector(space, 125);      // 250 for mobile, 125 for PC
  boxRadii = (space + RADII)/2;
  game = new GameManager();
}

void draw() {
  background(#5C679B);              //0DDC6F
  if (game.hasEnded() == false)
    game.run(); 
  else game.showResult();
}

void mousePressed() {
  if (game.hasEnded() == false)
    game.mousePressed();
}

void keyPressed() {
  game.keyPressed();
}
