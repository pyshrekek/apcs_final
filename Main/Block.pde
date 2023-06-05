public class Block {
  ArrayList<Wall> walls;
  final int SIZE = 100;
  int l, r, t, b;
  int tol = 2;
  float hp;

  public Block(int x, int y) {
    l = x;
    r = x + SIZE;
    t = y;
    b = y + SIZE;
    stroke(255);
    fill(255);
    walls = new ArrayList<Wall>(4);
    walls.add(new Wall(x, y, x, y + SIZE)); // l
    walls.add(new Wall(x + SIZE, y + SIZE, x + SIZE, y)); // r
    walls.add(new Wall(x, y, x + SIZE, y)); // t
    walls.add(new Wall(x + SIZE, y + SIZE, x, y + SIZE)); /// b
    hp = 1000;
  }

  public Block withinBlock(Player p) {
    if (p.pos.x > l - tol && p.pos.x < r + tol && p.pos.y > t - tol && p.pos.y < b + tol) return this;
    else return null;
  }

  public int closestEdge(PVector p) {
    int index = 0;
    int i = 0;
    float min = 9999999;

    for (Wall w : walls) {
      float curr = lineDistance(w.start, w.end, p);
      if (curr < min) {
        min = curr;
        index = i;
      }

      i++;
    }

    return index;
  }

  void hurt(float amount) {
    hp -= amount;
  }
}

ArrayList<Integer> checkBlockHP(ArrayList<Block> blocks) {
  ArrayList<Integer> indices = new ArrayList<>();
  for (int i = 0; i < blocks.size(); i++) {
    if (blocks.get(i).hp <= 0) {
      indices.add(i);
    }
  }

  return indices;
}
