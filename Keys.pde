class Keys {
  PFont def;
  PImage keyIcon;
  int globalIndex;
  char keysArr[] = new char[1000];
  int x, y;
  Keys() {
    def = createFont("Arial", 32);
    keyIcon = loadImage("keyIcon.png");
    for (int i = 0; i <= 999; i++) {
      keysArr[i] = (char) int(random(32, 126));
      for (int j = 0; j <= i; j++) {
        if (keysArr[i]== keysArr[j]) {
          //randomSeed(millis());
          keysArr[i] = (char) int(random(32, 126));
        }
      }
    }
  }

  void displayKey() {
    textFont(def);
    textSize(66);
    imageMode(CENTER);
    image(keyIcon, x, y, displayHeight - 792, displayHeight - 792);
    textAlign(CENTER);
    fill(0);
    text(keysArr[globalIndex], x, y + 15);
    if (globalIndex >= 998) { globalIndex = 0; }
  }
}
