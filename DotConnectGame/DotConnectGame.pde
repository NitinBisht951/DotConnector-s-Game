final float RADII = 10;              // 10 for mobile, 6 for PC
final byte NROWS = 9;              // 8 for mobile, 9 for PC
final byte NCOLS = 6;              // 6  for mobile, 10 for PC
final byte NPLAYERS = 2;
final int MAXSCORE = int(NROWS-1)*int(NCOLS-1);

PVector start;
float space;
PFont scoreFont, initialsFont;
float boxRadii;

StartMenu menu; 
GameManager game;
String[] playersName = {"AANCHAL", "ABHI"};
color[] idColors = new color[]{#BB7236, #A16BD1};

void setup() {
  //fullScreen();
  size(540, 960);         
  //size(displayWidth, displayHeight); //for mobile, size(600, 600) for PC

  init();
  menu = new StartMenu();
  game = new GameManager();
}

void draw() {
  background(#96a7ba);              //0DDC6F 5C679B 96a7ba
  println(mouseX,mouseY);
  if (menu.isAlive()) {
    menu.showOptions();
  } else {
    if (game.hasEnded() == false)
      game.run(); 
    else game.showResult();
  }
}

void mouseReleased() {
  if (menu.isAlive()) menu.mouseReleased ();
}

void mousePressed() {
  if (!menu.isAlive() && game.hasEnded() == false)
    game.mousePressed();
}

void keyPressed() {
  game.keyPressed();
}

void init () {
  strokeCap(SQUARE);
  scoreFont = loadFont("BookmanOldStyle-Bold-32.vlw");
  initialsFont = loadFont("BookmanOldStyle-Bold-32.vlw");
  textFont(scoreFont, 40);                // 40 for mobile, 32 for PC
  space = (width-RADII*NCOLS)/(2+NCOLS-1);
  start = new PVector(space, 250);      // 250 for mobile, 125 for PC
  boxRadii = (space + RADII)/2;
}
