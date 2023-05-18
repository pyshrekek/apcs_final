import processing.event.KeyEvent;
import java.util.HashMap;
import processing.core.*;

ArrayList<Wall> walls;
Ray ray;
Player player;
int sceneW, sceneH;
HashMap<Character, Boolean> keys;
private PApplet applet;

void setup() {
  size(1600, 800);

  this.applet = this;
  applet.registerMethod("keyEvent", this);
  keys = new HashMap<Character, Boolean>();

  sceneW = width/2;
  sceneH = height;

  walls = new ArrayList<Wall>(5);
  for (int i = 0; i < 5; i++) {
    float x1 = random(sceneW);
    float y1 = random(sceneH);
    float x2 = random(sceneW);
    float y2 = random(sceneH);
    walls.add(new Wall(x1, y1, x2, y2));
  }
  walls.add(new Wall(0, 0, sceneW, 0));
  walls.add(new Wall(sceneW, 0, sceneW, height));
  walls.add(new Wall(sceneW, height, 0, height));
  walls.add(new Wall(0, height, 0, 0));



  player = new Player();
  player.update(100, 100);
}

void draw() {
  background(0);


  // show all walls
  for (Wall wall : walls) {
    wall.show();
  }

  player.show();
  ArrayList<Float> scene = player.cast(walls);
  float w = (width / 2) / scene.size();

  // render what the rays see
  push();
  translate(sceneW, 0);
  for (int i = 0; i < scene.size(); i++) {
    noStroke();
    float sq = scene.get(i)*scene.get(i);
    float widthSq = (sceneW)*(sceneW);
    float fill = map(sq, 0, widthSq, 255, 0);
    float h = map(scene.get(i), 0, sceneW + 1, height, 0);
    fill(fill);
    rectMode(CENTER);

    rect(i * w + w / 2, height/2, w, h);
  }
  pop();

  if (keys.containsKey('w') && keys.get('w')) player.move(3, 0);
  if (keys.containsKey('s') && keys.get('s')) player.move(-3, 0);
  if (keys.containsKey('a') && keys.get('a')) player.move(0, -3);
  if (keys.containsKey('d') && keys.get('d')) player.move(0, 3);
  if (keys.containsKey('j') && keys.get('j')) player.rotate(-0.05);
  if (keys.containsKey('l') && keys.get('l')) player.rotate(0.05);
  
  println(player.pos.x, player.pos.y);
}

public void keyEvent(KeyEvent event) {
  Character key = event.getKey();

  switch (event.getAction()) {
  case KeyEvent.PRESS:
    if (keyCode == LEFT) {
      keys.put('j', true);
    } else if (keyCode == RIGHT) {
      keys.put('l', true);
    } else {
      keys.put(Character.toLowerCase(key), true);
    }
    break;
  case KeyEvent.RELEASE:
    if (keyCode == LEFT) {
      keys.put('j', false);
    } else if (keyCode == RIGHT) {
      keys.put('l', false);
    } else {
      keys.put(Character.toLowerCase(key), false);
    }
    break;
  }
}
