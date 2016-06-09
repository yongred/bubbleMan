/**
chest class represent obj bubble can blow up. It might contain items
to powerup the agents (bubble/potion)
*/
class chest {
  PImage img = loadImage("box.png");
  location chestLoc;
  boolean containItem;
  item itemInside;
  
  chest(){
    chestLoc = new location();
    randItem();
  }
  
  chest(location loc){
    chestLoc = loc;
    randItem();
  }
  
  chest(int x, int y){
    chestLoc = new location(x, y);
    randItem();
  }
  
  void draw(){
    image(img, chestLoc.getX(), chestLoc.getY()); 
  }
  
  location getLoc(){
    return chestLoc;
  }
  
  void randItem(){
    int randNum = (int) random(100) + 1;
    if(randNum <= 50){//test
      containItem = true;
      itemInside = new item(chestLoc);
    }
    else{
      containItem = false;
    }
  }
  
  boolean isContainItem(){
    return containItem;
  }
  
  item getItem(){
    return itemInside;
  }
  
  
}