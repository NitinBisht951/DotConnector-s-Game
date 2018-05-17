final float RADII = 6;
final byte NROWS = 4;
final byte NCOLS = 4;
final byte NPLAYERS = 2;
final int MAXSCORE = int(NROWS-1)*int(NCOLS-1);

PVector start;
float space;
PFont tFont;
float boxRadii;

GameManager game;
String[] playersName = {"Ankur", "Nitin"};
// Bauhaus93-32 Broadway-32 Computerfont-32 GoudyStout-32 Mathematica6-Bold-32
void setup() {
  size(600, 600);
  tFont = loadFont("Computerfont-32.vlw");
  textFont(tFont, 28);
  space = (width-RADII*NCOLS)/(4+NCOLS-1);
  start = new PVector(2*space, 3*space);
  boxRadii = (space + RADII)/2;
  game = new GameManager();
}

void draw() {
  background(180);
  if (game.hasEnded() == false)
    game.run();
  else game.showResult();
}

void mouseClicked() {
  game.mouseClicked();
}

void keyPressed() {
  game.keyPressed();
}
