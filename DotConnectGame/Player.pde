class Player {
  String name;
  int score;
  
  Player(String name) {
    this.name = name;
    this.score = 0;
  }
  
  String getName() {
    return name;
  }
  
  int getScore() {
    return score; 
  }
  
  void updateScore() {
    score++;
  }
}
