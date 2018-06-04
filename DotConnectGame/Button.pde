class Button {
  String label;
  float posY;

  Button(String label, float posY) {
    this.label = label;
    this.posY = posY;
  }

  void show() {
    drawBoundary();
    fill(0);
    textAlign(CENTER, CENTER);
    text(label.toUpperCase(), width/2, posY);
    textAlign(BASELINE);
  }

  void drawBoundary() {
    fill(255);
    strokeWeight(6);
    rectMode(CENTER);
    stroke(100);
    if(!isClicked())
      rect(width/2, posY+5, width/3-10, textAscent()+40);   
    stroke(0);
    rect(width/2, posY, width/3, textAscent()+40);
    rectMode(CORNER);
    //strokeWeight(20);
    //point(width/3, posY -textAscent()/2-20);
    //point(2*width/3, posY -textAscent()/2-20);
    //point(2*width/3, posY + textAscent()/2+20);
    //point(width/3, posY + textAscent()/2+20);
  }

  boolean isClicked() {
    boolean clicked = ((mouseX > width/3)&&(mouseX < 2*width/3))&&((mouseY > (posY -textAscent()/2-20))&&(mouseY < posY + textAscent()/2+20));
    return clicked;
  }
}
