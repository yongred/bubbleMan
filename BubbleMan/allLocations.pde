
public static class allLocations{
  public static ArrayList<location> mapLocations = new ArrayList<location>();
  public static ArrayList<location> openLocations = new ArrayList<location>();
  public static ArrayList<location> saveLocations = new ArrayList<location>();
  
  public static boolean checkOpenLocs(location locate){
     boolean contain = false;
    for(location loc: openLocations){
      if(loc.x == locate.x
        && loc.y == locate.y){
        contain = true;
      }
    }
    return contain;
  }
  
  public static void initOpenLocs(){
    for(location loc : mapLocations){
      if(!blocks.checkContainLoc(loc) && !chests.checkContainLoc(loc) && !bubblesdropped.checkContainLoc(loc)){
        //println(loc.x + " " + loc.y);
        openLocations.add(loc);
      }
    }
    
  }//end calopenlocs
  
  public static void removeFromOpen(location locate){
    location target = null;
    for(location loc: openLocations){
      if(loc.x == locate.x 
        && loc.y == locate.y){
        target = loc;
      }
    }
    //println("map " + mapLocations.size());
    //println("open " + openLocations.size());
    //println("target " + target);
    if(target != null){
      openLocations.remove(target);
    }
    //println("open " + openLocations.size());
  }
  
  public static void addToOpen(location loc){
    if(!checkOpenLocs(loc)){
      openLocations.add(loc);
    }
  }
  
  public static void initSaveLocs(){
    saveLocations = new ArrayList<location>( openLocations);
  }
  
  public static void removeFromSave(location locate){
    location target = null;
    int count = 0;
    for(location loc: saveLocations){
      if(loc.x == locate.x 
        && loc.y == locate.y){
        target = loc;
        count++;
      }
    }
    if(target != null){
      saveLocations.remove(target);
      //println("remove : " + target.x + " " + target.y + " count " + count);
    }
  }
  
   public static boolean checkSaveLocs(location locate){
     boolean contain = false;
    for(location loc: saveLocations){
      if(loc.x == locate.x
        && loc.y == locate.y){
          //println("in checkSave x : " + locate.x + " y " + locate.y );
        contain = true;
      }
    }
    return contain;
  }
  
  public static void addToSave(location loc){
    if(!checkSaveLocs(loc)){
      saveLocations.add(loc);
    }
  }
  
  public static ArrayList<location> sortedSaveLocs(location AILoc, ArrayList<location> list, int leftInd, int rightInd){
     ArrayList<location> listCopy = new ArrayList<location> (list);
    int pivotInd = partition(AILoc, listCopy, leftInd, rightInd);
    //println(pivotInd+ " " + leftInd + " " + rightInd);
    if(leftInd < pivotInd)
      return sortedSaveLocs(AILoc, listCopy, leftInd, pivotInd-1);
    if(rightInd > pivotInd)
      return sortedSaveLocs(AILoc, listCopy, pivotInd, rightInd);
    else
      return listCopy;
  }
  
  public static int partition(location AILoc, ArrayList<location> list, int leftInd, int rightInd){
    location pivot = list.get(rightInd);
    int leftPointer = leftInd;
    int rightPointer = rightInd;
    
    while(true){
      while(getDistance(AILoc, list.get(leftPointer)) < 
          getDistance(AILoc, pivot) ){
            leftPointer++;
      }
      //println("in left " + leftPointer + " " + rightPointer);
      while(rightPointer > 0  && 
         getDistance(AILoc, list.get(rightPointer)) > getDistance(AILoc, pivot) ){
          rightPointer--;
      }
      //println("in right " + leftPointer + " " + rightPointer);
      if(leftPointer >= rightPointer)
        break;
        
      else{
        location temp = list.get(leftPointer);
        list.set(leftPointer, list.get(rightPointer));
        list.set(rightPointer, temp);
        leftPointer++;
        rightPointer--;
      }
      
    }//while true
    
    return leftPointer;
  }//end partition
  
  public static double getDistance(location AILoc, location loc){
    return sqrt( sq(loc.x - AILoc.x) + sq(loc.y - AILoc.y)); //distance formula, not that good in our case
    //return abs(loc.x - AILoc.x) + abs(loc.y - AILoc.y);
  }
  
  
  
}