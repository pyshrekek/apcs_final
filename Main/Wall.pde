class Wall {
  PVector start, end;
  boolean enemy;

  public Wall(float x1, float y1, float x2, float y2) {
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
  }

  public Wall(PVector start, PVector end) {
    this.start = start;
    this.end = end;
  }

  void show() {
    stroke(255);
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);
  }
}
