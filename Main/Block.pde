class Block {
  float x, y;
  ArrayList<Wall> walls;
  // size 20
  
  public Block(int x, int y) {
    this.x = x;
    this.y = y;
    stroke(255);
     fill(255);
     walls = new ArrayList<Wall>(4);
     walls.add(new Wall(x, y, x + 20, y));
     walls.add(new Wall(x, y, x, y + 20));
     walls.add(new Wall(x + 20, y + 20, x + 20, y));
     walls.add(new Wall(x + 20, y + 20, x, y + 20));
  }
  
  void show() {
     for (Wall wall : walls) {
       wall.show(); 
     }
  }
  
  ArrayList<Wall> getWalls() {
    return walls;
  }
}
