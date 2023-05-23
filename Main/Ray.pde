class Ray {
  PVector pos, dir;

  public Ray(float x, float y) {
    pos = new PVector(x, y);
    dir = new PVector(1, 0);
  }

  public Ray(PVector v) {
    pos = v;
    dir = new PVector(1, 0);
  }

  // angle in radians
  public Ray(PVector v, float angle) {
    pos = v;
    dir = new PVector(cos(angle), sin(angle));
  }

  void show() {
    stroke(255, 100);
    pushMatrix();
    translate(pos.x, pos.y);
    line(0, 0, dir.x * 10, dir.y * 10);
    popMatrix();
  }
  
  // https://stackoverflow.com/questions/24173966/raycasting-engine-rendering-creating-slight-distortion-increasing-towards-edges
  // https://stackoverflow.com/questions/66644579/how-do-i-fix-warped-walls-in-my-raycaster
  // https://gamedev.stackexchange.com/questions/156842/how-can-i-correct-an-unwanted-fisheye-effect-when-drawing-a-scene-with-raycastin

  PVector cast(Wall wall) {
    // wall bounds
    float x1 = wall.start.x;
    float y1 = wall.start.y;
    float x2 = wall.end.x;
    float y2 = wall.end.y;

    // ray bounds
    float x3 = this.pos.x;
    float y3 = this.pos.y;
    float x4 = x3 + this.dir.x;
    float y4 = y3 + this.dir.y;

    // intersection formula https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
    float denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (denominator == 0) {
      return null;
    }

    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
    float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator;

    if (t > 0 && t < 1 && u > 0) {
      PVector intersect = new PVector();
      intersect.x = x1 + t*(x2 - x1);
      intersect.y = y1 + t*(y2 - y1);
      return intersect;
    } else {
      return null;
    }
  }

  void setDir(float x, float y) {
    this.dir.x = x - this.pos.x;
    this.dir.y = y - this.pos.y;
    this.dir.normalize();
  }

  // angle in radians
  void setDir(float angle) {
    dir.x = cos(angle);
    dir.y = sin(angle);
  }
}
