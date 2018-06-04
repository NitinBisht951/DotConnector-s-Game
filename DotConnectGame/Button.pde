class Button {
  String label;
  float posY;
  
  Button(String label, float posY) {
    this.label = label;
    this.posY = posY;
  }

  void show () {
    fill (255);
    stroke (0);
    strokeWeight (6);
    drawBoundary ();
    fill (0);
    textAlign(CENTER, CENTER);
    text (label.toUpperCase (), width/2, posY);
    textAlign (BASELINE);
  }
  
  void drawBoundary () {
    rectMode(CENTER);
    rect (width/2,posY,width/3,textAscent ()+40);
    rectMode(CORNER);
    strokeWeight(20);
    point(width/3,posY -textAscent()/2-20);
    point(2*width/3,posY -textAscent()/2-20);
    point(2*width/3,posY + textAscent()/2+20);
    point(width/3,posY + textAscent()/2+20);
  }
  
  boolean isClicked() {
    boolean clicked = ((mouseX > width/3)&&(mouseX < 2*width/3))&&((mouseY > (posY -textAscent()/2-20))&&(mouseY < posY + textAscent()/2+20));
    return clicked;
  }
}
