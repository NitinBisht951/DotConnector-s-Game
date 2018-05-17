class GameManager {
  Player[] player = new Player[NPLAYERS];
  Dot[][] dots = new Dot[NROWS][NCOLS];
  Box[][] boxes = new Box[NROWS-1][NCOLS-1];
  byte pTurnIndex;
  boolean changeTurn;
  byte clicks;
  PVector fDotIndexes;
  boolean gameEnd;
  byte winnerIndex;

  GameManager() {
    for (int i = 0; i < NPLAYERS; i++) 
      player[i] = new Player(playersName[i]);
    for (byte r = 0; r < NROWS-1; r++) {
      for (byte c = 0; c < NCOLS-1; c++) {
        boxes[r][c] = new Box(new PVector(start.x+RADII/2+(2*c+1)*boxRadii, start.y+RADII/2+(2*r+1)*boxRadii));
      }
    }
    dotsInit();
    this.pTurnIndex = 1;
    this.changeTurn();
    this.clicks = 0;
    this.fDotIndexes = new PVector(0, 0);
    this.winnerIndex = -1;
    this.changeTurn = true;
    this.gameEnd = false;
  }

  boolean hasEnded() {
    return gameEnd;
  }

  void eyeOnScores() {
    int score0 = player[0].getScore();
    int score1 = player[1].getScore();
    int leftScore = MAXSCORE-(score0+score1);
    if(abs(score0 - score1) > leftScore) {
      gameEnd = true;
      if(score0 > score1) winnerIndex = 0;
      else winnerIndex = 1;
    }
  }

  void showResult() {
    textSize(40);
    textAlign(CENTER, CENTER);
    text(player[winnerIndex].getName()+", you are the winner", width/2, height/2);
  }

  void dotsInit() {
    for (byte r = 0; r < NROWS; r++) {
      float rStart = start.y + r*(space+RADII);
      for (byte c = 0; c < NCOLS; c++) {
        float cStart = start.x + c*(space+RADII);
        dots[r][c] = new Dot(new PVector(cStart, rStart));
      }
    }
  }

  void run() {
    for (byte r = 0; r < NROWS; r++)
      for (byte c = 0; c < NCOLS; c++)
        dots[r][c].draw();
    for (byte r = 0; r < NROWS-1; r++) {
      for (byte c = 0; c < NCOLS-1; c++) {
        boxes[r][c].show();
      }
    }
    showScores();
    eyeOnScores();
  }

  void manageBoxes(PVector fDot, PVector lDot) {
    char pChar = player[pTurnIndex].getName().charAt(0);
    boolean turn = true;
    if (fDot.x == lDot.x) {         //when dots are on same row
      byte minC = byte(min(fDot.y, lDot.y));
      if (fDot.x < NROWS-1) { 
        boxes[byte(fDot.x)][minC].updateWalls('T', pChar);        
        if (boxes[byte(fDot.x)][minC].completed()) { 
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
      if (fDot.x > 0) {
        boxes[byte(fDot.x-1)][minC].updateWalls('B', pChar);
        if (boxes[byte(fDot.x-1)][minC].completed()) {
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
    } else {                        //when dots are on same column
      byte minR = byte(min(fDot.x, lDot.x));
      if (fDot.y < NCOLS-1) {
        boxes[minR][byte(fDot.y)].updateWalls('L', pChar);
        if (boxes[minR][byte(fDot.y)].completed()) { 
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
      if (fDot.y > 0) { 
        boxes[minR][byte(fDot.y-1)].updateWalls('R', pChar);
        if (boxes[minR][byte(fDot.y-1)].completed()) {
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
    }
    changeTurn = turn;
  }

  void mouseClicked() {
    PVector indexes = getIndexes();
    if (indexes.x >= 0) {
      if (clicks == 0) {
        println("start index : ", byte(indexes.x), byte(indexes.y));
        clicks = 1;
        fDotIndexes = indexes;
      } else if (clicks == 1) {
        println("last index : ", byte(indexes.x), byte(indexes.y));
        clicks = 0;
        if (((fDotIndexes.x == indexes.x)^(fDotIndexes.y == indexes.y))&&((abs(fDotIndexes.x - indexes.x)==1)^(abs(fDotIndexes.y - indexes.y)==1))) 
        { 
          boolean cheating = areDotsConnected(fDotIndexes, indexes);
          if (cheating == true) { 
            println("Don't try to be OverSmart, CHEATER!!!"); 
            return;
          } else {
            manageBoxes(fDotIndexes, indexes);
            dots[byte(fDotIndexes.x)][byte(fDotIndexes.y)].mouseClicked();
            dots[byte(indexes.x)][byte(indexes.y)].mouseClicked();
            if (changeTurn == true) changeTurn();
          }
        }
      }
    }
  }

  void changeTurn() {
    if (pTurnIndex == 0) pTurnIndex = 1;
    else pTurnIndex = 0;
    println(player[pTurnIndex].getName()+"'s turn");
  }

  boolean areDotsConnected(PVector fDotIndexes, PVector indexes) {
    boolean b = dots[byte(fDotIndexes.x)][byte(fDotIndexes.y)].isFilled() && dots[byte(indexes.x)][byte(indexes.y)].isFilled();
    if (fDotIndexes.x == indexes.x) {
      byte minC = byte(min(fDotIndexes.y, indexes.y));
      if (indexes.x > 0) b = b && boxes[byte(indexes.x-1)][minC].getBottomWallStatus();
      else b = b && boxes[byte(indexes.x)][minC].getTopWallStatus();
    } else if (fDotIndexes.y == indexes.y) {
      byte minR = byte(min(fDotIndexes.x, indexes.x));
      if (indexes.y > 0) b = b && boxes[minR][byte(indexes.y-1)].getRightWallStatus();
      else b = b && boxes[minR][byte(indexes.y)].getLeftWallStatus();
    }
    return b;
  }

  void keyPressed() {
    if (key == 'c') clicks = 0;
    else if (key == 'p') {
      for (byte r = 0; r < NROWS-1; r++) {
        for (byte c = 0; c < NCOLS-1; c++) {
          print("Box[", r, "][", c, "]");
          boxes[r][c].printWallsStatus();
        }
      }
    }
  }

  void showScores() {
    for (int i = 0; i < NPLAYERS; i++) {
      if (pTurnIndex == i) {
        stroke(#03FF1D);
        strokeWeight(10);
        point(70+i*300, 50);
        strokeWeight(1);
      }
      fill(0);
      text(player[i].getName(), 100+i*300, 50);
      text(player[i].getScore(), 100+i*300, 80);
    }
  }

  PVector getIndexes() {
    PVector indexes = new PVector(0, 0);
    boolean cFlag = false;
    boolean rFlag = false;
    for (int c = 0; c < NCOLS; c++) {
      if (mouseX > (start.x + c*(space+RADII)) && mouseX < (start.x + c*(space+RADII) + RADII)) {
        indexes.y = c;
        cFlag = true;
        break;
      }
    }
    for (int r = 0; r < NROWS; r++) {
      if (mouseY > (start.y + r*(space+RADII)) && mouseY < (start.y + r*(space+RADII) + RADII)) {
        indexes.x = r;
        rFlag = true;
        break;
      }
    }
    if (cFlag && rFlag) return indexes;
    else return new PVector(-1, -1);
  }
}
