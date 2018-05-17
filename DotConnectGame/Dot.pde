class Dot {
  PVector position;
  boolean filled;

  Dot(PVector position) {
    this.position = position;
    filled = false;
  }

  void draw() {
    stroke(0);
    if(filled == false) fill(255);
    else fill(0);
    rect(position.x,position.y,RADII,RADII);
  }
  
  void setFilled() {
    filled = true;
  }
  
  void mouseClicked() {
     setFilled();
  }
  
  boolean isFilled() {
   return filled; 
  }
}
