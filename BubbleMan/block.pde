/**
block class represent objects that cannot it blowed by bubbles
cannot pass through
*/
class block {
  PImage img = loadImage("tree.png");
  location blockLoc;
  
  block(){
    blockLoc = new location();
  }
  
  block(location loc){
    blockLoc = loc;
  }
  
  block(int x, int y){
    blockLoc = new location(x, y);
  }
  
  void draw(){
    image(img, blockLoc.getX(), blockLoc.getY()); 
  }
  
  location getLoc(){
    return blockLoc;
  } 
}