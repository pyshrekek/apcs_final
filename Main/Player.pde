class Player {
  private static final float ANGLE_INCREMENT = .25;
  private static final int FOV = 40;
  PVector pos;
  ArrayList<Ray> rays;
  float heading;


  public Player() {
    pos = new PVector(width/2, height/2);
    rays = new ArrayList<Ray>();
    heading = 0;
    
    
    // if extra time, add adjusted ray headings
    for (float ang = -FOV / 2; ang < FOV / 2; ang += ANGLE_INCREMENT) {
      rays.add(new Ray(pos, radians(ang)));
    }
  }

  void update(float x, float y) {
    pos.x = x;
    pos.y = y;
  }

  void show() {
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, 8, 8);
  }

  // cast to a singular wall
  void cast(Wall wall) {
    for (Ray ray : rays) {
      if (ray.cast(wall) != null) {
        strokeWeight(1);
        line(pos.x, pos.y, ray.cast(wall).x, ray.cast(wall).y);
      }
    }
  }

  // cast to an ArrayList of walls
  ArrayList<Float> cast(ArrayList<Wall> walls) {
    ArrayList<Float> scene = new ArrayList<Float>();
    
    // for each ray that the player casts:
    for (Ray ray : rays) {
      PVector intersect = null;
      PVector closest = null;
      
      // super big number that will never be smaller than a distance
      float minDist = 34028234663852885981170418348451692544.0;

      // for each wall that a ray may/may not hit:
      for (Wall wall : walls) {
        intersect = ray.cast(wall);
        if (intersect != null) {
          float dist = dist(pos.x, pos.y, intersect.x, intersect.y);
          float ang = ray.dir.heading() - this.heading;
          dist *= cos(ang); // cosine correction
          if (dist < minDist) {
            minDist = dist;
            closest = intersect;
          }
        }
      }

      if (closest != null) {
        stroke(0, 255, 0, 50);
        line(pos.x, pos.y, closest.x, closest.y);
      }
      scene.add(minDist);
    }

    return scene;
  }

  void rotate(float angle) {
    this.heading += angle;
    for (int i = 0; i < rays.size(); i++) {
      rays.get(i).dir.rotate(angle);
    }
  }

  void move(float forward, float horizontal) {
    PVector forwardsVelocity = new PVector(cos(heading), sin(heading));
    PVector horizontalVelocity = new PVector(-sin(heading), cos(heading));
    forwardsVelocity.setMag(forward);
    horizontalVelocity.setMag(horizontal);
    pos.add(forwardsVelocity);
    pos.add(horizontalVelocity);

    if (pos.x >= sceneW - 1) {
      pos.x = sceneW - 1;
    }
    if (pos.x <= 1) {
      pos.x = 1;
    }
    if (pos.y >= sceneH - 1) {
      pos.y = sceneH - 1;
    }
    if (pos.y <= 1) {
      pos.y = 1;
    }
  }

  void collis(ArrayList<Block> blocks) {
    for (Block b : blocks) {
      if (b.withinBlock(this) != null) {
        if (b.closestEdge(pos) == 0) { // left
           pos.x = b.l - b.tol;
        } else if (b.closestEdge(pos) == 1) { // right
           pos.x = b.r + b.tol;
        } else if (b.closestEdge(pos) == 2) { // top
           pos.y = b.t - b.tol;
        } else if (b.closestEdge(pos) == 3) { // bottom
           pos.y = b.b + b.tol;
        }
      }
    }
  }
}
