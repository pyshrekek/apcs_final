public class Block {
  ArrayList<Wall> walls;
  final int SIZE = 100;
  int l, r, t, b;

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
  }

  public Block withinBlock(Player p) {
    if (p.pos.x > l && p.pos.x < r && p.pos.y > t && p.pos.y < b) return this;
    else return null;
  }

  public Wall closestEdge(PVector p) {
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

    return walls.get(index);
  }

  float lineDistance(PVector start, PVector end, PVector point) {
    PVector projection, temp;

    temp = PVector.sub(end, start);

    float lineLength = temp.x * temp.x + temp.y * temp.y; //lineStart.dist(lineEnd);

    if (lineLength == 0F) {
      return point.dist(start);
    }

    float t = PVector.dot(PVector.sub(point, start), temp) / lineLength;

    if (t < 0F) {
      return point.dist(start);
    }

    if (t > lineLength) {
      return point.dist(end);
    }

    projection = PVector.add(start, PVector.mult(temp, t));

    return point.dist(projection);
  }
}
