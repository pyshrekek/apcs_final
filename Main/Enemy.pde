class Enemy {
  PVector pos, dir;
  float hp;

  public Enemy(PVector pos, PVector dir) {
    this.pos = pos;
    this.dir = dir;
    hp = 100;
  }

  void show() {
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 8, 8);
  }

  void hurt(float amount) {
    hp -= amount;
  }
}
