final float RADII = 6;              // 10 for mobile, 6 for PC
final byte NROWS = 9;              // 8 for mobile, 9 for PC
final byte NCOLS = 10;              // 6  for mobile, 10 for PC
final byte NPLAYERS = 2;
final int MAXSCORE = int(NROWS-1)*int(NCOLS-1);

PVector start;
float space;
PFont scoreFont, initialsFont;
float boxRadii;

GameManagers game;
String[] playersName = {"ANKUR", "NITIN"};
color[] idColors = new color[]{#8DD169, #A16BD1};

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
  game = new GameManagers();
}

void draw() {
  background(#96a7ba);              //0DDC6F 5C679B
  if (game.hasEnded() == false)
    game.run(); 
  else game.showResult();
}

void mousePressed() {
  if (game.hasEnded() == false)
    game.mousePressed();
}

void mouseReleased() {
  if (game.hasEnded() == false)
    game.mouseReleased();
}

void keyPressed() {
  game.keyPressed();
}
