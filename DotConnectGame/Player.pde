class Player {
  String name;
  int score;
  color idColor;

  Player(String name, color idColor) {
    this.name = name;
    this.score = 0;
    this.idColor = idColor;
  }

  String getName() {
    return name;
  }

  int getScore() {
    return score;
  }

  color getIdColor() {
    return idColor;
  }

  void updateScore() {
    score++;
  }
}
