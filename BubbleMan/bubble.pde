/**
bubble class is the object agent drop, it can explode to kill agents.
properties include: explosion length, timer to track it. And how long blasting
animation last
*/
class bubble {
  PImage img = loadImage("bubble.png");
  PImage blastImg = loadImage("blast.png");
  int blastLen; 
  int blastTimer, blastStartTime, blastX, blastY;    //x, y when dropped, blast
  int leftBlast, rightBlast, upBlast, downBlast;    //blast index for each dir
  boolean dropped;
  boolean blasting;
  int x, y, timer, startTime;
  ArrayList<location> thisBlastLocs = new ArrayList<location>();
  ArrayList<location> thisChestLocs = new ArrayList<location>();
  
  bubble(){
    x = -1;
    y = -1;
    timer = 3000; //in miliseconds
    startTime = 0;
    dropped = false;
    blastTimer = 400;
    blastStartTime = 0;
    blasting = false;
    blastLen = 1;
  }
  
  bubble(agent character) {
    x = character.getX();
    y = character.getY();
    timer = 3000;
    startTime = 0;
    dropped = false;
    blastTimer = 400;
    blastStartTime = 0;
    blasting = false;
    blastLen = character.getPowerLen();
  }
  
  bubble(int x, int y){
    this.x = x;
    this.y = y;
    timer = 3000;
    startTime = 0;
    dropped = false;
    blastTimer = 400;
    blastStartTime = 0;
    blasting = false;
    blastLen = 1;
  }
  
  //update time count down (default 3 secs) for bubble to blast
  void update() {
    if(startTime == 0){
      startTime = millis();
    }
    int timeNow = millis();
    int change = timeNow - startTime;
    // println("change: " + change);
    //println("timeNow: " + timeNow);
    //println("startTime: " + startTime);
    timer -= change;
    startTime = timeNow;
  }
  
  //blasting time last
  void blastUpdate(){
    if(blastStartTime == 0){
      blastStartTime = millis();
    }
    int timeNow = millis();
    int change = timeNow - blastStartTime;
    blastTimer -= change;
    blastStartTime = timeNow;
  }
  
  //reset after finish blasting
  void finishBlast(){
    blastTimer = 400;
    blastStartTime = 0;
    blasting = false;
  }
  
  void draw(){
    image(img, x, y);
  }
  
  void drawBlast(){
    image(blastImg, x, y);
    for(int i=1; i<= blastLen; i++){
      int gridChange = i * 40;
      if(leftBlast >= i){
        image(blastImg, blastX - gridChange, blastY); //left
      }
      if(rightBlast >= i){
        image(blastImg, blastX + gridChange, blastY);// right
      }
      if(upBlast >= i){
        image(blastImg, blastX, blastY - gridChange);//up
      }
      if(downBlast >= i){
        image(blastImg, blastX, blastY + gridChange);//down
      }
    }
  }
  
  
  public void decreaseSaveLocs(){
    //lengths, stopped at where it hits a obj
    //continues determine whether blasts goes on
    boolean leftContinue = true, rightContinue = true;
    boolean upContinue = true, downContinue = true;
    //center on the bubble is also effected
    location centerLoc = new location(x,y);
    allLocations.removeFromSave(centerLoc); //check bubble current location dropped
    //println("centerLoc : " + centerLoc.x + " " + centerLoc.y);
    bubblesdropped.addToBlast(centerLoc);
    thisBlastLocs.add(centerLoc);
    
    for(int i=1; i<= blastLen; i++){
      int gridChange = i * 40;
      
      location leftLoc = new location(x - gridChange, y);
      location rightLoc = new location(x + gridChange, y);
      location upLoc = new location(x, y - gridChange);
      location downLoc = new location(x, y + gridChange);
      //check blocks and chests blasts hit
      chest leftChest = chests.getContainChest(leftLoc);
      chest rightChest = chests.getContainChest(rightLoc);
      chest upChest = chests.getContainChest(upLoc);
      chest downChest = chests.getContainChest(downLoc);
         
        if(blocks.checkContainLoc(leftLoc) && leftContinue){
           //leftBlast = i-1;
           leftContinue = false;
        }
        else if(leftChest != null && leftContinue){
          //println("left: " + leftChest);
           //leftBlast = i;
           //thisBlastLocs.add(leftLoc);
           thisChestLocs.add(leftLoc);
           bubblesdropped.blastChestLocs.add(leftChest.getLoc());
           allLocations.removeFromSave(leftLoc);
           leftContinue = false;
        }
        
        //right
        
        if(blocks.checkContainLoc(rightLoc) && rightContinue){
          //rightBlast = i-1;
          rightContinue = false;
        }
        else if(rightChest != null && rightContinue){
           //println("right: " + rightChest);
          //rightBlast = i;
          //thisBlastLocs.add(rightLoc);
          thisChestLocs.add(rightLoc);
          bubblesdropped.blastChestLocs.add(rightChest.getLoc());
          allLocations.removeFromSave(rightLoc);
          rightContinue = false;
        }
        
        
        //up
        
        if(blocks.checkContainLoc(upLoc) && upContinue){ //up
          //upBlast = i-1;
          upContinue = false;
        }
        else if(upChest != null && upContinue){ //up
          //println("up: " + upChest);
          //upBlast = i;
          //thisBlastLocs.add(upLoc);
          thisChestLocs.add(upLoc);
          bubblesdropped.blastChestLocs.add(upChest.getLoc());
          allLocations.removeFromSave(upLoc);
          upContinue = false;
        }
        
        //down
        
        if(blocks.checkContainLoc(downLoc) && downContinue){//down
          //downBlast = i-1;
          downContinue = false;
        }
        else if(downChest != null && downContinue){//down
          //println("down: " + downChest);
          //downBlast = i;
          //thisBlastLocs.add(downLoc);
          thisChestLocs.add(downLoc);
          bubblesdropped.blastChestLocs.add(downChest.getLoc());
          allLocations.removeFromSave(downLoc);
          downContinue = false;
        }
        
        //left
       if(leftContinue){
         allLocations.removeFromSave(leftLoc);
         bubblesdropped.addToBlast(leftLoc);
         thisBlastLocs.add(leftLoc);
       }
       if(rightContinue){
          allLocations.removeFromSave(rightLoc);
          bubblesdropped.addToBlast(rightLoc);
          thisBlastLocs.add(rightLoc);
       }
       if(upContinue){
          allLocations.removeFromSave(upLoc);
          bubblesdropped.addToBlast(upLoc);
          thisBlastLocs.add(upLoc);
       }
       if(downContinue){
          allLocations.removeFromSave(downLoc);
          bubblesdropped.addToBlast(downLoc);
          thisBlastLocs.add(downLoc);
       }
      
    }//end loop 
    //println("-----");
    //println("size decrease: " + allLocations.saveLocations.size());
  }//end locBlasted
  
  public void recoverSaveLocs(){
    
    for(location loc: thisBlastLocs){
      if(bubblesdropped.duplicatedBlast(loc) > 1){
        bubblesdropped.removeFromBlast(loc);
        
        continue;
      }
      
      allLocations.addToSave(loc);
      bubblesdropped.removeFromBlast(loc);
    }
    //check chest location blasted, if 
    for(location loc: thisChestLocs){
      if(bubblesdropped.duplicatedChest(loc) > 1){
        bubblesdropped.removeFromChest(loc);
        //bubblesdropped.removeFromChest(loc);
        //println("duplicate " + loc.x + " " + loc.y);
        continue;
      }
      
      allLocations.addToSave(loc);
      bubblesdropped.removeFromChest(loc);
    }
    //println("size recover: " + allLocations.saveLocations.size());
  }
  
  
  void checkBlasted(){
    //lengths, stopped at where it hits a obj
    leftBlast = rightBlast = upBlast = downBlast = blastLen;
    //continues determine whether blasts goes on
    boolean leftContinue = true, rightContinue = true;
    boolean upContinue = true, downContinue = true;
    
    for(int i=1; i<= blastLen; i++){
      int gridChange = i * 40;
      //check blocks and chests blasts hit
      chest leftChest = chests.getContainChest(
            new location(blastX - gridChange, blastY));
      chest rightChest = chests.getContainChest(
            new location(blastX + gridChange, blastY));
      chest upChest = chests.getContainChest(
            new location(blastX, blastY - gridChange));
      chest downChest = chests.getContainChest(
            new location(blastX, blastY + gridChange));
      //left
      if(blocks.checkContainLoc(blastX - gridChange, blastY) && leftContinue){
         leftBlast = i-1;
         leftContinue = false;
      }
      else if(leftChest != null && leftContinue){
        //println("left: " + leftChest);
         leftBlast = i;
         if(leftChest.isContainItem())
          items.itemList.add(leftChest.getItem());
         chests.chestList.remove(leftChest);
         leftContinue = false;
         
         allLocations.addToOpen(leftChest.getLoc()); //add to open space, since chest blowed
          
           addBlastChest(leftChest.getLoc());
          // thisBlastLocs.add(leftChest.getLoc());
          //bubblesdropped.blastingLocs.add(leftChest.getLoc()); //for save areas calc
      }
      //right
      if(blocks.checkContainLoc(blastX + gridChange, blastY) && rightContinue){
        rightBlast = i-1;
        rightContinue = false;
      }
      else if(rightChest != null && rightContinue){
         //println("right: " + rightChest);
        rightBlast = i;
        if(rightChest.isContainItem())
          items.itemList.add(rightChest.getItem());
        chests.chestList.remove(rightChest);
        allLocations.addToOpen(rightChest.getLoc());
        rightContinue = false;
        
         addBlastChest(rightChest.getLoc());
         //bubblesdropped.blastChestLocs.add(rightChest.getLoc()); //for save areas calc
         //thisBlastLocs.add(rightChest.getLoc());
          //bubblesdropped.blastingLocs.add(rightChest.getLoc()); //for save areas calc
      }
      //up
      if(blocks.checkContainLoc(blastX, blastY - gridChange) && upContinue){ //up
        upBlast = i-1;
        upContinue = false;
      }
      else if(upChest != null && upContinue){ //up
        //println("up: " + upChest);
        upBlast = i;
        if(upChest.isContainItem())
          items.itemList.add(upChest.getItem());
        chests.chestList.remove(upChest);
        allLocations.addToOpen(upChest.getLoc());
        upContinue = false;
        
        addBlastChest(upChest.getLoc());
         //bubblesdropped.blastChestLocs.add(upChest.getLoc()); //for save areas calc
         //thisBlastLocs.add(upChest.getLoc());
          //bubblesdropped.blastingLocs.add(upChest.getLoc()); //for save areas calc
      }
      
      //down
      if(blocks.checkContainLoc(blastX, blastY + gridChange) && downContinue){//down
        downBlast = i-1;
        downContinue = false;
      }
      else if(downChest != null && downContinue){//down
        //println("down: " + downChest);
        downBlast = i;
        if(downChest.isContainItem())
          items.itemList.add(downChest.getItem());
        chests.chestList.remove(downChest);
        allLocations.addToOpen(downChest.getLoc());
        downContinue = false;
        
        addBlastChest(downChest.getLoc());
         //bubblesdropped.blastChestLocs.add(downChest.getLoc()); //for save areas calc
         //thisBlastLocs.add(downChest.getLoc());
          //bubblesdropped.blastingLocs.add(downChest.getLoc()); //for save areas calc
      }
      
    }//end loop 
    
    //check agent blasted
    blastedAgentCheck();
    
  }//end check blasted
  
  void blastedAgentCheck(){
    //check (0,0)center place, on the bomb
    for(agent blastedAg : agents.allAgents){
      //agent blastedAg = agents.getContainAgent(new location(x, y));
      if(blastedAg.x == x && blastedAg.y == y)
        blastedAg.setAlive(false);
      //check agents left
      for(int i=1; i<= leftBlast; i++){
        int gridChange = i * 40;
        if(blastedAg.x == x - gridChange && blastedAg.y == y)
          blastedAg.setAlive(false);
      }
      //check agents right
      for(int i=1; i<= rightBlast; i++){
        int gridChange = i * 40;
       if(blastedAg.x == x + gridChange && blastedAg.y == y)
          blastedAg.setAlive(false);
      }
      //check agents up
      for(int i=1; i<= upBlast; i++){
        int gridChange = i * 40;
        if(blastedAg.x == x  && blastedAg.y == y - gridChange)
          blastedAg.setAlive(false);
      }
      //check agents down
      for(int i=1; i<= downBlast; i++){
        int gridChange = i * 40;
        if(blastedAg.x == x && blastedAg.y == y + gridChange)
          blastedAg.setAlive(false);
      }
    }
  }
  
  public boolean predictBlastAgent(location centerLoc){
    //lengths, stopped at where it hits a obj
    int leftBlast, rightBlast, upBlast,  downBlast;
    leftBlast = rightBlast = upBlast = downBlast = blastLen;
    //continues determine whether blasts goes on
    boolean leftContinue = true, rightContinue = true;
    boolean upContinue = true, downContinue = true;
    
    for(int i=1; i<= blastLen; i++){
      int gridChange = i * 40;
      
      location leftLoc = new location(centerLoc.x - gridChange, centerLoc.y);
      location rightLoc = new location(centerLoc.x + gridChange, centerLoc.y);
      location upLoc = new location(centerLoc.x, centerLoc.y - gridChange);
      location downLoc = new location(centerLoc.x, centerLoc.y + gridChange);
      //check blocks and chests blasts hit
      chest leftChest = chests.getContainChest(leftLoc);
      chest rightChest = chests.getContainChest(rightLoc);
      chest upChest = chests.getContainChest(upLoc);
      chest downChest = chests.getContainChest(downLoc);
      //left
      if(blocks.checkContainLoc(leftLoc) && leftContinue){
         leftBlast = i-1;
         leftContinue = false;
      }
      else if(leftChest != null && leftContinue){
        //println("left: " + leftChest);
         leftBlast = i;
        
         leftContinue = false;
         
      }
      //right
      if(blocks.checkContainLoc(rightLoc) && rightContinue){
        rightBlast = i-1;
        rightContinue = false;
      }
      else if(rightChest != null && rightContinue){
         //println("right: " + rightChest);
        rightBlast = i;
        
        rightContinue = false;
      }
      //up
      if(blocks.checkContainLoc(upLoc) && upContinue){ //up
        upBlast = i-1;
        upContinue = false;
      }
      else if(upChest != null && upContinue){ //up
        //println("up: " + upChest);
        upBlast = i;
        
        upContinue = false;
        
        
      }
      
      //down
      if(blocks.checkContainLoc(downLoc) && downContinue){//down
        downBlast = i-1;
        downContinue = false;
      }
      else if(downChest != null && downContinue){//down
        //println("down: " + downChest);
        downBlast = i;
        
        downContinue = false;
        
        
      }
      
    }//end loop 
    
    //check (0,0)center place, on the bomb
      
      if(agents.myPlayer.x == centerLoc.x && agents.myPlayer.y == centerLoc.y){
        //println("center: " + centerLoc.x + " " + centerLoc.y);
        return true;
      }
      //check agents left
      for(int i=1; i<= leftBlast; i++){
        int gridChange = i * 40;
        if(agents.myPlayer.x == (centerLoc.x - gridChange) && agents.myPlayer.y == centerLoc.y){
          //println("left: " + (centerLoc.x - gridChange) + " " + centerLoc.y);
          return true;
        }
      }
      //check agents right
      for(int i=1; i<= rightBlast; i++){
        int gridChange = i * 40;
        if(agents.myPlayer.x == (centerLoc.x + gridChange) && agents.myPlayer.y == centerLoc.y){
          return true;
        }
      }
      //check agents up
      for(int i=1; i<= upBlast; i++){
        int gridChange = i * 40;
        if(agents.myPlayer.x == centerLoc.x && agents.myPlayer.y == (centerLoc.y - gridChange))
          return true;
      }
      //check agents down
      for(int i=1; i<= downBlast; i++){
        int gridChange = i * 40;
        if(agents.myPlayer.x == centerLoc.x && agents.myPlayer.y == (centerLoc.y + gridChange))
          return true;
      }
      
      return false;
  }
  
  //call when bubble timer == 0, blast
  void blast(){
    blastX = x;
    blastY = y;
    checkBlasted();
    dropped = false;
    bubblesdropped.bubbleList.remove(this);
    timer = 3000;
    startTime = 0;
    blasting = true;
    //println("blast len: " + blastLen);
    //after blast recover areas
    allLocations.addToOpen(new location(x, y));
    recoverSaveLocs(); //blasted area remove from save areas 
    thisBlastLocs.clear();
    thisChestLocs.clear();
    mapcells.fillBlocked(); //update area open
    
    for(agent ag: agents.allAgents){ //if blast power up is eatten when this bubble is dropped
      ag.checkBlastPower();
    }
    //println("size save: " + allLocations.saveLocations.size());
  }
  
  //prediction if this bubble dropped
  public ArrayList<location> predictSaveLocs(location centerLoc){
    ArrayList<location> predictSave = new ArrayList<location> (allLocations.saveLocations);
     ArrayList<location> predictSaveCopy = new ArrayList<location> (allLocations.saveLocations);
    boolean leftContinue = true, rightContinue = true;
    boolean upContinue = true, downContinue = true;
    //center on the bubble is also effected
    for(location loc : predictSaveCopy){
       if(centerLoc.x == loc.x && centerLoc.y == loc.y){
          predictSave.remove(loc);
       }
    }
    
    for(int i=1; i<= blastLen; i++){
      int gridChange = i * 40;
      
      location leftLoc = new location(centerLoc.x - gridChange, centerLoc.y);
      location rightLoc = new location(centerLoc.x + gridChange, centerLoc.y);
      location upLoc = new location(centerLoc.x, centerLoc.y - gridChange);
      location downLoc = new location(centerLoc.x, centerLoc.y + gridChange);
      //check blocks and chests blasts hit
      chest leftChest = chests.getContainChest(leftLoc);
      chest rightChest = chests.getContainChest(rightLoc);
      chest upChest = chests.getContainChest(upLoc);
      chest downChest = chests.getContainChest(downLoc);
         
        if(blocks.checkContainLoc(leftLoc) && leftContinue){
           leftContinue = false;
        }
        else if(leftChest != null && leftContinue){
           leftContinue = false;
        }
        
        //right
        
        if(blocks.checkContainLoc(rightLoc) && rightContinue){
          rightContinue = false;
        }
        else if(rightChest != null && rightContinue){
          rightContinue = false;
        }
        
        //up
        if(blocks.checkContainLoc(upLoc) && upContinue){ //up
          upContinue = false;
        }
        else if(upChest != null && upContinue){ //up
          upContinue = false;
        }
        
        //down
        if(blocks.checkContainLoc(downLoc) && downContinue){//down
          downContinue = false;
        }
        else if(downChest != null && downContinue){//down
          downContinue = false;
        }
        
        //left
       if(leftContinue){
         for(location loc : predictSaveCopy){
           if(leftLoc.x == loc.x && leftLoc.y == loc.y){
              predictSave.remove(loc);
            //println("leftLoc: " + leftLoc.x + " " + leftLoc.y);
           }
         }
       }
       if(rightContinue){
         for(location loc : predictSaveCopy){
           if(rightLoc.x == loc.x && rightLoc.y == loc.y)
              predictSave.remove(loc);
         }
       }
       if(upContinue){
         for(location loc : predictSaveCopy){
           if(upLoc.x == loc.x && upLoc.y == loc.y)
              predictSave.remove(loc);
         }
       }
       if(downContinue){
         for(location loc : predictSaveCopy){
           if(downLoc.x == loc.x && downLoc.y == loc.y)
              predictSave.remove(loc);
         }
       }
      
    }//end loop 
    return predictSave;
  }//end predict
  
  //add to this blast chest without duplicate
  public void addBlastChest(location locate){
    location target = null;
    for(location loc: thisChestLocs){
      if(loc.x == locate.x 
        && loc.y == locate.y){
        target = loc;
      }
    }
    
    if(target == null){
      
      thisChestLocs.add(locate);
    }
    //else
      //println("duplicate " + target.x + " " + target.y);
  }
  
  //getters and setters
  boolean isDropped(){
    return dropped;
  }
  
  boolean isBlasting(){
    return blasting;
  }
  
  void setDropped(boolean isDrop){
    dropped = isDrop;
  }
  
  void setBlasting(boolean blast){
    blasting = blast;
  }
  
  void setLoc(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void setLoc(location loc){
    x = loc.getX();
    y = loc.getY();
  }
  
  int getTimer(){
    return timer;
  }
  
  int getBlastTimer(){
    return blastTimer;
  }
  
  int getBlastLen(){
    return blastLen;
  }
  
  void setBlastLen(int len){
    blastLen = len;
  }
  
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  void setX(int x){
    this.x = x;
  }
  void setY(int y){
    this.y = y;
  }
  
  
}