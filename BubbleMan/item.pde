/************************************************************
* Item class to decide which item will randomly drop        *
* from the box upon breaking                                *
* Depending on the item, the agents ability will go up      *
* Get functions to retrieve the methods about the item      *
************************************************************/
class item{
  PImage potionItemImg = loadImage("potionItem.png");
  PImage bubbleItemImg = loadImage("bubbleItem.png");
  int probability; //probability of getting an item
  int itemIdentity; //1 = portion, 2= bubble
  location itemLoc;
  
  item(){
    //probability = 50;
    itemIdentity = (int)random(2)+1;
    itemLoc = new location(0,0);
  }
  
  item(location loc){
    //probability = 50;
    itemIdentity = (int)random(2)+1;
    itemLoc = loc;
  }
  
  void draw(){
    if(itemIdentity == 1)
      image(potionItemImg, itemLoc.getX(), itemLoc.getY());
    else if(itemIdentity == 2)
      image(bubbleItemImg, itemLoc.getX(), itemLoc.getY());
  }
  
  //enhance ability for the agent base on the item
  void equipAbility(agent ag){
    if(itemIdentity == 1){ //blast len + 1
      ag.blastPowerUp();
    }
    else if(itemIdentity == 2){ // bubble + 1
      ag.bubblePowerUp();
    }
  }
  
  //return identity of the item
  int getIdentity(){
    return itemIdentity;
  }
  
  //return location of the item
  location getLoc(){
    return itemLoc;
  }
  
}