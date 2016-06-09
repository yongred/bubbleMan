/************************************************************
* Location class to hold places or location for objects     *
* around the game screen                                    *
* Getters and Setters for each location                     *
************************************************************/
class location {
  int x;
  int y;
  
  location() {
    x = 0;
    y = 0;
  }
  
  location(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  void setX(int x) {
    this.x = x;
  }
  
  void setY(int y) {
    this.y = y;
  }
}