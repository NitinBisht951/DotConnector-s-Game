class GameManager {
  Player[] player = new Player[NPLAYERS];
  Dot[][] dots = new Dot[NROWS][NCOLS];
  Box[][] boxes = new Box[NROWS-1][NCOLS-1];
  color[] idColors = new color[]{#F0B177,#B977F0};

  byte pTurnIndex;
  boolean changeTurn;
  byte clicks;
  PVector firstDotIndexes;
  boolean gameEnd;
  byte winnerIndex;

  GameManager() {
    for (int i = 0; i < NPLAYERS; i++) 
      player[i] = new Player(playersName[i],idColors[i]);
    for (byte r = 0; r < NROWS-1; r++) {
      for (byte c = 0; c < NCOLS-1; c++) {
        boxes[r][c] = new Box(new PVector(start.x+RADII/2+(2*c+1)*boxRadii, start.y+RADII/2+(2*r+1)*boxRadii));
      }
    }

    initDots();
    this.pTurnIndex = 1;
    this.changeTurn();
    this.clicks = 0;
    this.firstDotIndexes = new PVector(0, 0);
    this.winnerIndex = -1;
    this.changeTurn = true;
    this.gameEnd = false;
  }

  void initDots() {
    for (byte r = 0; r < NROWS; r++) {
      float rStart = start.y + r*(space+RADII);
      for (byte c = 0; c < NCOLS; c++) {
        float cStart = start.x + c*(space+RADII);
        dots[r][c] = new Dot(new PVector(cStart, rStart));
      }
    }
  }

  void run() {
  
    for (byte r = 0; r < NROWS-1; r++) {
      for (byte c = 0; c < NCOLS-1; c++) {
        boxes[r][c].show();
      }
    }
  for (byte r = 0; r < NROWS; r++) {
      for (byte c = 0; c < NCOLS; c++) {
        dots[r][c].draw();
      }
    }
    showScores();
    eyeOnScores();
  }

  boolean hasEnded() {
    return gameEnd;
  }

  void showScores() {
    float spaceFactor = textWidth (player [0].getName ()) + 100;                                 
    float upMargin = 100-textAscent ()/2;
    for (int i = 0; i < NPLAYERS; i++) {
      fill (player [i].getIdColor ());
      stroke (0);
      strokeWeight (2);
      ellipse (50+i*spaceFactor,upMargin,30,30);
       if (pTurnIndex == i) {
        pushStyle();
        strokeCap(ROUND);
        stroke(#000000);
        strokeWeight(15);
        point(100+i*spaceFactor, upMargin);                                    // 100 for mobile, 50 for PC
        popStyle();
      }
      fill(0);
      text(player[i].getName(), 80+i*spaceFactor, 100);                 // 100 for mobile, 50 for PC
      text(player[i].getScore(), 80+i*spaceFactor, 160);                // 160 for mobile, 90 for PC
    }
  }

  void eyeOnScores() {
    int score0 = player[0].getScore();
    int score1 = player[1].getScore();
    if (MAXSCORE == score0+score1) {
      gameEnd = true;
      if (score0 > score1) winnerIndex = 0;
      else if (score0 < score1) winnerIndex = 1;
      else winnerIndex = -1;
    }
  }

  void showResult() {
    String result;
    if (winnerIndex != -1)
     result = player[winnerIndex].getName() + ", you won";
     else result = "IT is a TIE";
    
    rectMode(CENTER);
    fill (255,30);
    float w =  textWidth(result) + 50;
    rect(width/2, height/2, w, 60, 5);
    textSize(40);
    textAlign(CENTER, CENTER);
    fill(0);
    text(result, width/2, height/2);
  }

  void changeTurn() {
    if (pTurnIndex == 0) pTurnIndex = 1;
    else pTurnIndex = 0;
    println(player[pTurnIndex].getName()+"'s turn");
  }

  void manageBoxes(PVector fDot, PVector lDot) {
    char pChar = player[pTurnIndex].getName().charAt(0);
    boolean turn = true;
    if (fDot.x == lDot.x) {         //when dots are on same row
      byte minC = byte(min(fDot.y, lDot.y));
      if (fDot.x < NROWS-1) { 
        boxes[byte(fDot.x)][minC].updateWalls('T');        
        if (boxes[byte(fDot.x)][minC].completed()) { 
          boxes[byte(fDot.x)][minC].conquerBox(pChar,idColors[pTurnIndex]);
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
      if (fDot.x > 0) {
        boxes[byte(fDot.x-1)][minC].updateWalls('B');
        if (boxes[byte(fDot.x-1)][minC].completed()) {
          boxes[byte(fDot.x-1)][minC].conquerBox(pChar,idColors[pTurnIndex]);
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
    } else {                        //when dots are on same column
      byte minR = byte(min(fDot.x, lDot.x));
      if (fDot.y < NCOLS-1) {
        boxes[minR][byte(fDot.y)].updateWalls('L');
        if (boxes[minR][byte(fDot.y)].completed()) { 
          boxes[minR][byte(fDot.y)].conquerBox(pChar,idColors[pTurnIndex]);
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
      if (fDot.y > 0) { 
        boxes[minR][byte(fDot.y-1)].updateWalls('R');
        if (boxes[minR][byte(fDot.y-1)].completed()) {
          boxes[minR][byte(fDot.y-1)].conquerBox(pChar,idColors[pTurnIndex]);
          player[pTurnIndex].updateScore();
          turn = false;
        }
      }
    }
    changeTurn = turn;
  }

  void mousePressed() {
    PVector lastDotIndexes = getIndexes();
    if (lastDotIndexes.x >= 0) {
      if (clicks == 0) {
        println("start index : ", byte(lastDotIndexes.x), byte(lastDotIndexes.y));
        clicks = 1;
        firstDotIndexes = lastDotIndexes;
        dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].setCol(#FF0000);
      } else if (clicks == 1) {
        println("last index : ", byte(lastDotIndexes.x), byte(lastDotIndexes.y));
        if (((firstDotIndexes.x == lastDotIndexes.x)^(firstDotIndexes.y == lastDotIndexes.y))&&((abs(firstDotIndexes.x - lastDotIndexes.x)==1)^(abs(firstDotIndexes.y - lastDotIndexes.y)==1))) 
        { 
          clicks = 0;
          boolean cheating = areDotsConnected(firstDotIndexes, lastDotIndexes);
          if (cheating == true) { 
            println("Don't try to be OverSmart, CHEATER!!!"); 
            dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].setCol(0);
            return;
          } else {
            manageBoxes(firstDotIndexes, lastDotIndexes);
            dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].setCol(0);
            dots[byte(lastDotIndexes.x)][byte(lastDotIndexes.y)].setCol(0);
            if (changeTurn == true) changeTurn();
          }
        } else if (firstDotIndexes.x == lastDotIndexes.x && firstDotIndexes.y == lastDotIndexes.y) {
          clicks = 0;
          if (dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].isFilled() == true) 
            dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].setCol(0);
          else dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].setCol(255);
        }
      }
    }
  }

  boolean areDotsConnected(PVector firstDotIndexes, PVector lastDotIndexes) {
    boolean b = dots[byte(firstDotIndexes.x)][byte(firstDotIndexes.y)].isFilled() && dots[byte(lastDotIndexes.x)][byte(lastDotIndexes.y)].isFilled();
    if (firstDotIndexes.x == lastDotIndexes.x) {
      byte minC = byte(min(firstDotIndexes.y, lastDotIndexes.y));
      if (lastDotIndexes.x > 0) b = b && boxes[byte(lastDotIndexes.x-1)][minC].getBottomWallStatus();
      else b = b && boxes[byte(lastDotIndexes.x)][minC].getTopWallStatus();
    } else if (firstDotIndexes.y == lastDotIndexes.y) {
      byte minR = byte(min(firstDotIndexes.x, lastDotIndexes.x));
      if (lastDotIndexes.y > 0) b = b && boxes[minR][byte(lastDotIndexes.y-1)].getRightWallStatus();
      else b = b && boxes[minR][byte(lastDotIndexes.y)].getLeftWallStatus();
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

  PVector getIndexes() {
    PVector lastDotIndexes = new PVector(0, 0);
    boolean cFlag = false;
    boolean rFlag = false;
    float touchMargin = 16;
    for (int c = 0; c < NCOLS; c++) {
      if (mouseX > (start.x + c*(space+RADII) - touchMargin) && mouseX < (start.x + c*(space+RADII) + RADII + touchMargin)) {
        lastDotIndexes.y = c;
        cFlag = true;
        break;
      }
    }
    for (int r = 0; r < NROWS; r++) {
      if (mouseY > (start.y + r*(space+RADII) - touchMargin) && mouseY < (start.y + r*(space+RADII) + RADII + touchMargin)) {
        lastDotIndexes.x = r;
        rFlag = true;
        break;
      }
    }
    if (cFlag && rFlag) return lastDotIndexes;
    else return new PVector(-1, -1);
  }
}
