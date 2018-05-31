class Dot {
  PVector position;
  boolean filled;
  color col = 255;

  Dot(PVector position) {
    this.position = position;
    this.col = 255;
    this.filled = false;
  }

  void draw() {
    stroke(0);
    strokeWeight(1);
    fill(col);
    ellipse(position.x+RADII/2, position.y+RADII/2, 2*RADII, 2*RADII);
    //rect(position.x, position.y, RADII, RADII);
  }

  void setCol(color col) {
    this.col = col;
    if (col == 0) filled = true;
  }

  boolean isFilled() {
    return filled;
  }
}
