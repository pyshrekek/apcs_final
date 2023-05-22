public class Block {
  float x, y;
  ArrayList<Wall> walls;
    final int SIZE = 100;

  public Block(int x, int y) {
    this.x = x;
    this.y = y;
    stroke(255);
    fill(255);
    walls = new ArrayList<Wall>(4);
    walls.add(new Wall(x, y, x + SIZE, y));
    walls.add(new Wall(x, y, x, y + SIZE));
    walls.add(new Wall(x + SIZE, y + SIZE, x + SIZE, y));
    walls.add(new Wall(x + SIZE, y + SIZE, x, y + SIZE));
  }
}
