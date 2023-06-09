class Enemy {
  PVector pos, dir;
  float hp;
  Wall wall;

  public Enemy(PVector pos, PVector dir) {
    this.pos = pos;
    this.dir = dir;
    hp = 100;
    wall = new Wall(pos.x-5, pos.y, pos.x+5, pos.y);
  }

  void show() {
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 8, 8);
  }

  void hurt(float amount) {
    hp -= amount;
  }
}

ArrayList<Integer> checkHP(ArrayList<Enemy> enemies) {
  ArrayList<Integer> indices = new ArrayList<>();
  for (int i = 0 ; i < enemies.size() ; i++) {
    if (enemies.get(i).hp <= 0) {
      waah.play();
      indices.add(i);
    }
  }
  
  return indices;
}
