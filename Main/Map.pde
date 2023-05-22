class Map {
  int[][] map;
  ArrayList<Wall> walls;
  
  public Map(int[][] map) {
    this.map = map;
  }
  
  void show() {
    for(int i = 0 ; i < map.length ; i++) {
      for(int j = 0 ; j < map[i].length; j++) {
         if (map[i][j] == 1) {
           Block block = new Block(i * 20, j * 20); 
           block.show();
           ArrayList<Wall> temp = block.getWalls();
         }
      }
    }
  }
}
