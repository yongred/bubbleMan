
class AI extends agent{
  
  public static final int THINKING_TIME = 15;
  int thinkPeriod = THINKING_TIME;
  //ArrayList<location> saveAreas = new ArrayList<location>();
  ArrayList<location> sortedSaves = new ArrayList<location>();
  String name = "noName";
  AI(){
    super();
  }
  
  AI(int x, int y){
    super(x,y);
  }
  
  AI(int x, int y, PImage agentImg){
    super(x,y,agentImg);
  }
  
  AI(int x, int y, PImage agentImg, String name){
    super(x,y,agentImg);
    this.name = name;
  }
  
  public void makeDecision(){
    if(thinkPeriod < 0){
      thinkPeriod = THINKING_TIME;
    }
    
    else if (thinkPeriod == 0){
      //println("think " + thinkPeriod);
      sortedSaves = allLocations.sortedSaveLocs(
                        new location(this.x, this.y), allLocations.saveLocations, 0, allLocations.saveLocations.size()-1);
      boolean inSave = allLocations.checkSaveLocs(new location(this.x, this.y));
      location nextLoc = new location (Integer.MAX_VALUE, Integer.MAX_VALUE);
      boolean drop= false;
      //println("save " + inSave + "  " + this.x + " " + this.y);
      if(!inSave){
        ArrayList<gridcell> savePath = closestSavePath(sortedSaves);
        
        if(savePath != null && savePath.size() > 1){
          nextLoc = savePath.get(savePath.size() -2).loc;
        }
        //println(nextLoc.x + " dangerLoc " + nextLoc.y);
      }//danger
      else{
        ArrayList<gridcell> pathPlayer = pathToPlayer(); //path to player
        if(pathPlayer != null){
          int size = pathPlayer.size();
          //println(this.name + " can blast agent " + canBlastAgent());
          //println(this.name + " save to drop " + saveToDrop());
          if(canBlastAgent() && saveToDrop()){
            //println("can blast");
             drop= true;
          }
          //if(size <= 4 && saveToDrop() ) //close to opponent or can trap opponent, drop bubble
            //dropBubble();
          if(size > 1)
             nextLoc = pathPlayer.get(size -2).loc;  //size-2 is one move from agent's position, size-1 if agent's current pos
          if(!allLocations.checkSaveLocs(nextLoc)) //if the move is save area
              nextLoc = new location (Integer.MAX_VALUE, Integer.MAX_VALUE);
          //println(nextLoc.x + " pathOppo " + nextLoc.y);
        }
        
        else{ //pathOppo null
          ArrayList<gridcell> itemPath = itemSavePath(sortedSaves);
          ArrayList<gridcell> chestPath = chestSavePath(sortedSaves);
          if(itemPath != null){ //go to nearest save item place
            int size = itemPath.size();
            if(size > 1)
               nextLoc = itemPath.get(size -2).loc;  
            if(!allLocations.checkSaveLocs(nextLoc)) //if the move is save area
              nextLoc = new location (Integer.MAX_VALUE, Integer.MAX_VALUE);
          }
          else if(chestPath != null){ // go to nearest save chest (nestTo) place, drop bubble
            int size = chestPath.size();
            if(size > 1)
               nextLoc = chestPath.get(size -2).loc;  
            if(!allLocations.checkSaveLocs(nextLoc)) //if the move is save area
              nextLoc = new location (Integer.MAX_VALUE, Integer.MAX_VALUE);
          }
          if(nextToChest() && saveToDrop()){ //if next to a chest and is save to drop bubble, drop it
            println(this.name + " next chest ");
            drop= true;
          }
        }//else pathOppo == null
        
      }// else !inDanger
      if(drop)
        dropBubble();
      move(nextLoc); 
    }//end thinkPeroid == 0
    
    //println("period " +  thinkPeriod);
    thinkPeriod --;
  }//end makeDecision
  
  //find a path to opponent player
  public ArrayList<gridcell> pathToOppo(){
    ArrayList<gridcell> path = null;
    
    gridcell myPos = new gridcell(new location(this.x, this.y));
    for(agent ag: agents.allAgents){
      if(ag != this && ag.isAlive()){ //other agent
        location loc = new location(ag.x, ag.y);
        println("agent " + ag.x + " " + ag.y);
        gridcell oppoPos = new gridcell(loc);
        //println("pathOppo " + path);
        path = new pathfinding(myPos, oppoPos).Astar();
        if(path != null)
          return path;
      }
    }
    
    return path;
  }
  
  //find a path to opponent player
  public ArrayList<gridcell> pathToPlayer(){
    ArrayList<gridcell> path = null;
    
    gridcell myPos = new gridcell(new location(this.x, this.y));
    if(agents.myPlayer != this && agents.myPlayer.isAlive()){ //other agent
      location loc = new location(agents.myPlayer.x, agents.myPlayer.y);
      //println("agent " + agents.myPlayer.x + " " + agents.myPlayer.y);
      gridcell oppoPos = new gridcell(loc);
      //println("pathOppo " + path);
      path = new pathfinding(myPos, oppoPos).Astar();
      if(path != null)
        return path;
    }
    
    return path;
  }
  
  /*
  public boolean ableToTrap(){
    bubble bb = bubbles.get(0);
    ArrayList<location> predictSaves = bb.predictSaveLocs(new location(this.x, this.y)); //predict the save area for opponent after drop
    ArrayList<gridcell> path = null;
    for(location loc: predictSaves){
      gridcell saveArea = new gridcell(loc);
      gridcell myPos = new gridcell(getOpponentLoc());
      path = new pathfinding(myPos, saveArea).Astar();
      if(path == null) //not going to trap opponent
        return true;
    }
    return false;
  }*/
  
  //find the closest path to save position
  public ArrayList<gridcell> closestSavePath(ArrayList<location> sortedSaveLocs){
    ArrayList<gridcell> path = null;
    
    gridcell myPos = new gridcell(new location(this.x, this.y));
    
    for(location loc: sortedSaveLocs){
      gridcell saveArea = new gridcell(loc);
      path = new pathfinding(myPos, saveArea).Astar();
      if(path != null)
        return path;
    }
    
    return path;
  }
  
  //path to item that is on the save areas
  public ArrayList<gridcell> itemSavePath(ArrayList<location> sortedSaveLocs){
    ArrayList<gridcell> path = null;
    
    gridcell myPos = new gridcell(new location(this.x, this.y));
    for(location loc: sortedSaveLocs){
      if(items.checkContainLoc(loc)){
         gridcell saveItemArea = new gridcell(loc);
         path = new pathfinding(myPos, saveItemArea).Astar();
      }
      
      if(path != null)
        return path;
    }
    return path;
  }
  
  //find path to chest
  public ArrayList<gridcell> chestSavePath(ArrayList<location> sortedSaveLocs){
    ArrayList<gridcell> path = null;
    
    gridcell myPos = new gridcell(new location(this.x, this.y));
    for(location loc: sortedSaveLocs){
      boolean chestNext = false;
      //left
      if(chests.checkContainLoc(loc.x - 40, loc.y)){
         chestNext = true;
      }
      //right
      else if(chests.checkContainLoc(loc.x + 40, loc.y)){
         chestNext = true;
      }
      //up
      else if(chests.checkContainLoc(loc.x, loc.y - 40)){
         chestNext = true;
      }
      //down
      else if(chests.checkContainLoc(loc.x, loc.y + 40)){
         chestNext = true;
      }
      
      if(chestNext){
         gridcell chestSaveArea = new gridcell(loc);
         path = new pathfinding(myPos, chestSaveArea).Astar();
      }
      
      if(path != null)
        return path;
    }
    return path;
  }
  
  //next to a chest 
  public boolean nextToChest(){
    //left
      if(chests.checkContainLoc(this.x - 40, this.y)){
         return true;
      }
      //right
      if(chests.checkContainLoc(this.x + 40, this.y)){
         return true;
      }
      //up
      if(chests.checkContainLoc(this.x, this.y - 40)){
         return true;
      }
      //down
      if(chests.checkContainLoc(this.x, this.y + 40)){
         return true;
      }
      
      return false;
  }
  
  //if drop bubble here, is there save location to excape
  public boolean saveToDrop(){
    bubble bb = bubbles.get(0);
    ArrayList<location> predictSaves = bb.predictSaveLocs(new location(this.x, this.y));
    ArrayList<gridcell> path = null;
    for(location loc: predictSaves){
      gridcell saveArea = new gridcell(loc);
      gridcell myPos = new gridcell(new location(this.x, this.y));
      path = new pathfinding(myPos, saveArea).Astar();
       if(path != null)
        return true;
    }
    //println(path + "");
   
    return false;
  }
  
  //predict if drop here, can kill enemy they can't escape
  /*
  public boolean dropToTrap(){
    bubble bb = new ArrayList<bubble> (bubbles).get(0);
    location here = new location(this.x, this.y);
    gridcell cell = mapcells.getContainCell(here);
     
    ArrayList<location> predictSaves = bb.predictSaveLocs(here); //predict the save area for opponent after drop
    ArrayList<gridcell> path = null;
    cell.blocked = true;
    allLocations.removeFromOpen(here);
    for(location loc: predictSaves){
       
      gridcell saveArea = new gridcell(loc);
      gridcell oppoPos = new gridcell(getOpponentLoc());
      path = new pathfinding(oppoPos, saveArea).Astar();
       
    }
    //recover to state before pretend
    cell.blocked = false;
    allLocations.addToOpen(here);
    //println(path + "");
    
    if(path == null) // going to trap opponent
        return true;
    return false;
  }*/
  
  public boolean canBlastAgent(){
    bubble bb = new ArrayList<bubble> (bubbles).get(0);
    return bb.predictBlastAgent(new location (this.x, this.y));
  }
  
  /*
  //look for other player's location
  public location getOpponentLoc(){
    location loc = null;
    for(agent ag: agents.allAgents){
      if(ag != this){
        loc = new location(ag.x, ag.y);
      }
    }
   // println(loc.x + " getOppoLoc " + loc.y);
    return loc;
  }*/
  
  public void move(location loc){
    int dir = -1;
    if(y - velY == loc.y)
      dir = UP;
    else if(y + velY == loc.y)
      dir = DOWN;
    else if(x - velX == loc.x)
      dir = LEFT;
    else if(x + velX == loc.x)
      dir = RIGHT;

    if(dir != -1){
      super.move(dir); 
    }
  }
  
  
}