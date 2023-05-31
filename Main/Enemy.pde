class Enemy {
  PVector pos, dir;
  
  public Enemy(PVector pos, PVector dir) {
    this.pos = pos;
    this.dir = dir;
  }
  
  void show() {
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 8, 8);
  }
}
