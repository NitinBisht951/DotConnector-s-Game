class StartMenu {
  Button startButton;
  Button helpButton;
  Button exitButton;
  boolean startPlay;

  StartMenu() {
    float s = 350;
    startButton = new Button("Play", s);
    helpButton = new Button("Help", s+125);
    exitButton = new Button("Exit", s+250);
    startPlay = false;
  }

  void showOptions () {
    startButton.show ();
    helpButton.show ();
    exitButton.show ();
  }

  void mouseReleased() {
    if (startButton.isClicked()) startPlay = true;
    else if (helpButton.isClicked()); //show help;
    else if (exitButton.isClicked ()) exit ();
  }

  boolean isAlive () {
    return !startPlay;
  }
}
