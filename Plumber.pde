import processing.sound.*;

Animation plumberIdle, plumberRepairing;
Keys keys; 
SoundFile music;
PFont font;
PImage buttonUp, buttonDown;
PImage toilet;
boolean isPlumberRepairing;
boolean isPlaying;
boolean gameLost;
boolean isPressing;
boolean shouldChangeFps;
int start, delay, seconds, sot, plumbStart;
int waterStep;
int randomName;
PImage waterImg;
String[] names = {"Ms. Smith", "Joe's friend", "Uncle Samuel", "Mr. Doe", "Dr. Marbles", "Jenny"};

void setup() {
  size(displayHeight, displayHeight);
  font = createFont("PressStart2P.ttf", 32);
  textFont(font);
  toilet = loadImage("toilet.png");
  toilet.resize(width, height);
  background(toilet);
  music = new SoundFile(this, "theme.mp3");
  music.loop();
  randomSeed(floor(millis() * month() + random(random(0, 99), random(100, 287))));
  pixelDensity(1);
  isPlumberRepairing = false;
  plumberIdle = new Animation("character/idle", 2);
  plumberRepairing = new Animation("character/repairing", 3);
  buttonUp = loadImage("button/buttonUp.png");
  buttonDown = loadImage("button/buttonDown.png");
  keys = new Keys();
  delay = 1500;
}

void draw() {
  background(toilet);
  doFps();
  if (gameLost) {
    plumberDisplay();
    drawWater();
    drawLoseMenu();
    checkButtonLost();
  } else if (isPlaying) {
    plumberDisplay();
    keys.displayKey();
    checkWater();
    checkPlumber();
    drawWater();
    seconds = (millis() - sot) / 1000;
  } else {
    drawMenu();
  }
}

void plumberDisplay() {
  imageMode(CENTER);
  if (isPlumberRepairing) {
    plumberRepairing.display(width / 2 + width / 8, height / 2 + height / 16);
  } else {
    plumberIdle.display(width / 2 + width / 8, height / 2 + height / 16);
  }
}

void drawMenu() {
  fill(0);
  textAlign(CENTER);
  textSize(67);
  text("Mr.Plumber", width / 2, width / 8);
  checkButton();
}

void checkButton() {
  imageMode(CENTER);
  if (mouseX >= width / 2 - 256 && mouseX <= width / 2 + 256 && mouseY >= height / 2 - 64 && mouseY <= height / 2 + 64  && isPressing == true) {
    image(buttonUp, width / 2, height / 2);
    isPressing = false;
    isPlaying = true;
    start = millis();
    plumbStart = millis();
    shouldChangeFps = true;
    delay = 1500;
    waterStep = 15;
    sot = millis();
    waterImg = loadImage("water/tile0016.png");
    keys.x = floor(random(128, height - 128));
    keys.y = floor(random(128, height - 128));
  } else if (mouseX >= width / 2 - 256 && mouseX <= width / 2 + 256 && mouseY >= height / 2 - 64 && mouseY <= height / 2 + 64) {
    image(buttonDown, width / 2, height / 2);
  } else {
    image(buttonUp, width / 2, height / 2);
  }
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Start", width / 2, height / 2 + 15);
}

void mouseClicked() {
  if (mouseX >= width / 2 - 256 && mouseX <= width / 2 + 256 && mouseY >= height / 2 - 64 && mouseY <= height / 2 + 64) {
    isPressing = true;
  }
}

void doFps() {
  if (isPlaying && shouldChangeFps) {
    frameRate(3);
    shouldChangeFps = false;
  } else if (shouldChangeFps) { 
    frameRate(60);
    shouldChangeFps = false;
  }
}

void keyPressed() {
  println(key, keys.globalIndex);
  if (key == keys.keysArr[keys.globalIndex]) {
    keys.globalIndex += 1;
    delay += 1500;
    isPlumberRepairing = true;
    keys.x = floor(random(128, height - 128));
    keys.y = floor(random(128, height - 128));
  }
}

void checkWater() {
  if (delay <= millis() - start) {
    waterImg = loadImage("water/tile00" + waterStep + ".png");
    waterImg.resize(width, height);
    waterStep--;
    delay += 1500;
    if (waterStep <= 0) {
      gameLost = true;
      randomName = floor(random(0, 5));
      frameRate(60);
    }
  }
}

void drawWater() {
  imageMode(CENTER);
  image(waterImg, width / 2, height / 2);
}

void drawLoseMenu() {
  textSize(67);
  fill(0);
  text("You lost!", width / 2, height / 5);
  textSize(20);
  text("You repaired " + names[randomName] + "'s toilet for " + seconds + " seconds", width / 2, height / 4);
}

void checkPlumber() {
  if (3000 <= millis() - plumbStart && isPlumberRepairing) {
    isPlumberRepairing = false;
    plumbStart = millis();
  }
}

void checkButtonLost() {
  imageMode(CENTER);
  if (mouseX >= width / 2 - 256 && mouseX <= width / 2 + 256 && mouseY >= height / 2 - 64 && mouseY <= height / 2 + 64  && isPressing == true) {
    image(buttonUp, width / 2, height / 2);
    isPlaying = false;
    isPressing = false;
    gameLost = false;
  } else if (mouseX >= width / 2 - 256 && mouseX <= width / 2 + 256 && mouseY >= height / 2 - 64 && mouseY <= height / 2 + 64) {
    image(buttonDown, width / 2, height / 2);
  } else {
    image(buttonUp, width / 2, height / 2);
  }
  fill(255);
  textAlign(CENTER);
  textSize(30);
  textFont(font);
  text("Back to menu", width / 2, height / 2 + 15);
}
