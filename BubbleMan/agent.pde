/**
agent class for enemies, players. Properties include basic location, move functions,
dropping bubbles, alive status, and powerups.
*/

class agent {
  public static final int UP = 1, DOWN = 2, LEFT = 3, RIGHT = 4; 
  PImage agentImg;
  PImage deathImg = loadImage("grave.png");
  int x;
  int y;
  int velX;
  int velY;
  ArrayList<bubble> bubbles;
  int powerLen =1; //blast len
  boolean alive;
  
  agent() {
    x = 40;
    y = 40;
    velX = 40;
    velY = 40;
    alive = true;
    bubbles = new ArrayList<bubble>();
    bubbles.add(new bubble(this));
    agentImg = createImage(40, 40, RGB);
  }
  
  agent(int x, int y) {
    this.x = x;
    this.y = y;
    velX = 40;
    velY = 40;
    alive = true;
    bubbles = new ArrayList<bubble>();
    bubbles.add(new bubble(this));
   agentImg = createImage(40, 40, RGB);
  }
  
  agent(int x, int y, PImage agentImg){
    this.x = x;
    this.y = y;
    velX = 40;
    velY = 40;
    alive = true;
    bubbles = new ArrayList<bubble>();
    bubbles.add(new bubble(this));
    this.agentImg = agentImg;
  }
  
  void draw(){
    image(agentImg, x, y);
  }
  
  void move(int direction) {
    if(alive){
      
      switch(direction) {
        case 1: //up
          if(!checkBoundaries(UP)){
           y -= velY;
          }
          break;
        case 2: //down
          if(!checkBoundaries(DOWN)){
            y += velY;
          }
          break;
        case 3: //left
          if(!checkBoundaries(LEFT)){
            x -= velX;
          }
          break;
        case 4: //right
          if(!checkBoundaries(RIGHT)){
            x += velX;
          }
          break;
      }//switch
      checkGetItem();
    }//alive
  }//end move
  
  //when pressed key, drop an undropped bubble
  void dropBubble(){
    //println("dropBubble");
    if(alive){
      for(bubble obj: bubbles){
        if(!obj.isDropped()){
          obj.setLoc(x, y);
          obj.setDropped(true);
          bubblesdropped.bubbleList.add(obj);
          allLocations.removeFromOpen(new location(obj.x, obj.y));
          mapcells.fillBlocked();  //blocked area recalc
          obj.decreaseSaveLocs(); //bubble dropped, save places decreases
          break;
        }
      }
      
    }//alive
  }//end drop bubble
  
  //check if move to boundary, 
  boolean checkBoundaries(int dir){
    boolean blocked = false;
    int checkX = x;
    int checkY = y;
    switch(dir) {
      case UP: //up
        checkY = y - velY;
        if(checkY < 0){
          blocked = true;
        }
        break;
      case DOWN: //down
        checkY = y + velY;
        if(checkY >= height){
          blocked = true;
        }
        break;
      case LEFT: //left
        checkX = x - velX;
        if(checkX < 0){
          blocked = true;
        }
        break;
      case RIGHT: //right
        checkX = x + velX;
        if(checkX >= width){
          blocked = true;
        }
        break;
    }//switch end
    
    //check if there is a block where agent move to
    blocked = !allLocations.checkOpenLocs(new location(checkX, checkY));
    
    return blocked;
  }
  
  //died image when alive == false
  void drawDied(){
    image(deathImg, x, y);
  }
  //if encounter item
  void checkGetItem(){
    item obj = items.getContainItem(new location(x,y));
    if(obj != null){
      obj.equipAbility(this);
      items.itemList.remove(obj);
    }
  }
  
  ArrayList<bubble> getBubbles(){
    return bubbles;
  }
  
  //if location is at one of bubble's location
  /*
  boolean bubblesCheckLoc(int x, int y){
    boolean contain = false;
    for(bubble bb: bubbles){
      if(bb.getX() == x 
        && bb.getY() == y && bb.isDropped()){
        contain = true;
      }
    }
    return contain;
  }*/
  
  //when get item potion
  void blastPowerUp(){
    powerLen++;
    for(bubble bb: bubbles){
      if(!bb.isDropped())
        bb.setBlastLen(powerLen);
    }
    //println("potion, len: " + powerLen);
  }
  
  //check powerup after bubble not dropped/blasted
  public void checkBlastPower(){
    for(bubble bb: bubbles){
      if(!bb.isDropped())
        bb.setBlastLen(powerLen);
    }
  }
  
  //when get item bubble
  void bubblePowerUp(){
     bubbles.add(new bubble(this));
     //println("Bubble, size: " + bubbles.size());
  }
  //getter setters 
  void setAlive(boolean alive){
    this.alive = alive;
  }
  boolean isAlive(){
    return alive;
  }
  
  int getX() { return x; }
  int getY() { return y; }
  int getVelX(){
     return velX;
  }
  int getVelY(){
     return velY;
  }
  
  int getPowerLen(){
    return powerLen;
  }
  
  void setPowerLen(int len){
    powerLen = len;
  }
}