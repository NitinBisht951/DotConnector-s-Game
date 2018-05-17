class Box {
  boolean[] walls = new boolean[4];
  char playerInitial;
  boolean connected;
  PVector center;

  Box(PVector center) {
    this.center = center;
    walls[0] = false;                  //top
    walls[1] = false;                  //right
    walls[2] = false;                  //bottom
    walls[3] = false;                  //left
    playerInitial = 'P';
    connected = false;
  }

  void updateWalls(char wall, char playerInitial) {
    switch(wall) {
    case 'T' : 
      walls[0] = true;
      break;
    case 'R' : 
      walls[1] = true;
      break;
    case 'B' : 
      walls[2] = true;
      break;
    case 'L' : 
      walls[3] = true;
      break;
    default : 
      break;
    }
    connected = walls[0] && walls[1] && walls[2] && walls[3];
    if (connected) this.playerInitial = playerInitial;
  }

  boolean completed() {
    return connected;
  }

  void show() {
    showWalls();
    if (connected) {
      showName();
    }
  }

  void printWallsStatus() {
    println(walls[0], walls[1], walls[2], walls[3]);
  }

  void showName() {
    textAlign(CENTER,CENTER);
    text(playerInitial, center.x, center.y);
    textAlign(BASELINE);
  }

  void showWalls() {
    //strokeWeight(2);
    //point(center.x,center.y);
    float top = center.y-boxRadii;
    float left = center.x-boxRadii;
    float bottom = center.y+boxRadii;
    float right = center.x+boxRadii;
    if (walls[0]) line(left, top, right, top);
    if (walls[1]) line(right, top, right, bottom);
    if (walls[2]) line(left, bottom, right, bottom);
    if (walls[3]) line(left, top, left, bottom);
  }

  boolean getTopWallStatus() {
    return walls[0];
  }
  boolean getRightWallStatus() {
    return walls[1];
  }
  boolean getBottomWallStatus() {
    return walls[2];
  }
  boolean getLeftWallStatus() {
    return walls[3];
  }
}
