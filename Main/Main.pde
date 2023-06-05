import processing.event.KeyEvent;
import java.util.HashMap;
import processing.core.*;
import processing.sound.*;

SoundFile bang;
SoundFile boom;

static int[][] map;
static float speed = 1.5;

ArrayList<Wall> walls;
ArrayList<Block> blocks;
ArrayList<Enemy> enemies;
Ray ray;
Player player;
int sceneW, sceneH;
HashMap<Character, Boolean> keys;
private PApplet applet;

void setup() {
  size(1600, 800);
  smooth(8);
  imageMode(CENTER);
  bang = new SoundFile(this, "sounds/bang.wav");
  boom = new SoundFile(this, "sounds/boom.wav");

  this.applet = this;
  applet.registerMethod("keyEvent", this);
  keys = new HashMap<Character, Boolean>();

  sceneW = width/2;
  sceneH = height;

  walls = new ArrayList<Wall>();
  blocks = new ArrayList<Block>();
  enemies = new ArrayList<Enemy>();

  walls.add(new Wall(0, 0, sceneW, 0));
  walls.add(new Wall(sceneW, 0, sceneW, height));
  walls.add(new Wall(sceneW, height, 0, height));
  walls.add(new Wall(0, height, 0, 0));

  map = new int[][] {
    {0, 0, 1, 0, 0, 0, 0, 1},
    {0, 0, 0, 1, 1, 1, 0, 1},
    {1, 1, 0, 1, 1, 0, 0, 1},
    {0, 0, 0, 0, 0, 0, 0, 1},
    {0, 1, 0, 1, 1, 1, 0, 1},
    {0, 1, 0, 1, 1, 1, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 1},
  };

  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (map[j][i] == 1) {
        Block block = new Block(i * 100, j * 100);
        for (Wall wall : block.walls) {
          walls.add(wall);
        }
        blocks.add(block);
      }
    }
  }

  enemies.add(new Enemy(new PVector(250, 250), new PVector(1, 0)));

  for (Enemy e : enemies) {
    walls.add(e.wall);
  }

  player = new Player();
  player.update(100, 100);
}

void draw() {
  background(0);

  // show all walls
  for (Wall wall : walls) {
    wall.show();
  }
  for (Enemy enemy : enemies) {
    enemy.show();
  }
  player.show();
  ArrayList<Integer> toRemoveEnemies = checkHP(enemies);
  for (int i : toRemoveEnemies) {
    fill(255, 0, 0);
    rect(width/2, 0, width, height);
    walls.remove(enemies.get(i).wall);
    enemies.remove(i);
  }
  ArrayList<Integer> toRemoveBlocks = checkBlockHP(blocks);
  for (int i : toRemoveBlocks) {
    fill(0, 255, 0);
    rect(width/2, 0, width, height);
    for (Wall w : blocks.get(i).walls) {
      walls.remove(w);
    }
    blocks.remove(i);
  }

  ArrayList<Float> scene = player.cast(walls);

  float w = (width / 2) / scene.size();
  // render what the rays see
  push();
  translate(sceneW, 0);
  for (int i = 0; i < scene.size(); i++) {
    noStroke();
    float sq = scene.get(i)*scene.get(i);
    float widthSq = (sceneW)*(sceneW);
    float fill = map(sq, 0, widthSq, 230, 0);
    float h = map(scene.get(i), 0, sceneW + 1, height, 0);
    fill(fill);
    rectMode(CENTER);

    rect(i * w + w / 2, height/2, w, h);
  }
  pop();

  stroke(0, 255, 0);
  line(width*.75 - 10, height/2, width*.75 + 10, height/2);
  line(width*.75, height/2 - 10, width*.75, height/2 + 10);

  if (keys.containsKey('w') && keys.get('w')) player.move(speed, 0);
  if (keys.containsKey('s') && keys.get('s')) player.move(-speed, 0);
  if (keys.containsKey('a') && keys.get('a')) player.move(0, -speed);
  if (keys.containsKey('d') && keys.get('d')) player.move(0, speed);
  if (keys.containsKey('j') && keys.get('j')) player.rotate(-0.05);
  if (keys.containsKey('l') && keys.get('l')) player.rotate(0.05);
  if (keys.containsKey(' ') && keys.get(' ')) {
    player.shoot(enemies, blocks);
    
  }
  player.collis(blocks);
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
