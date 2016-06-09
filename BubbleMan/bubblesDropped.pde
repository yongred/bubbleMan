
public static class bubblesdropped{
  public static ArrayList<bubble> bubbleList = new ArrayList<bubble>();
  public static ArrayList<location> blastingLocs = new ArrayList<location>();
  public static ArrayList<location> blastChestLocs = new ArrayList<location>();
  
  public static boolean checkContainLoc(location loc){
    boolean contain = false;
    for(bubble obj: bubbleList){
      //println("contain: " + loc.x + " " + loc.y);
      //println("obj: " + obj.x + " " + obj.y);
      if(obj.getX() == loc.getX() 
        && obj.getY() == loc.getY()){
        contain = true;
      }
    }
    //println("contain: " + contain);
    return contain;
  }//end checkListBlasted
  
  //chest blasted location
  public static boolean checkBlastChest(location locate){
    boolean contain = false;
    for(location loc: blastChestLocs){
      //println("contain: " + loc.x + " " + loc.y);
      //println("obj: " + obj.x + " " + obj.y);
      if(locate.getX() == loc.getX() 
        && locate.getY() == loc.getY()){
        contain = true;
      }
    }
    //println("contain: " + contain);
    return contain;
  }//end checkListBlasted
  
   public static void removeFromChest(location locate){
    location target = null;
    for(location loc: blastChestLocs){
      if(loc.x == locate.x 
        && loc.y == locate.y){
        target = loc;
      }
    }
    if(target != null){
      //println("remove " + target.x + " " + target.y);
      blastChestLocs.remove(target);
    }
  }
  
  public static int duplicatedChest(location loc){
    int count = 0;
    for(location locate : blastChestLocs){
      if(loc.x == locate.x && loc.y == locate.y){
        //println(loc.x + " " + loc.y + " "+ locate.x + " " + locate.y);
        count++;
      }
    }
    //println(count);
    return count;
  }
  
  public static boolean checkBlastingLoc(location locate){
    boolean contain = false;
    for(location loc: blastingLocs){
      //println("contain: " + loc.x + " " + loc.y);
      //println("obj: " + obj.x + " " + obj.y);
      if(locate.getX() == loc.getX() 
        && locate.getY() == loc.getY()){
        contain = true;
      }
    }
    //println("contain: " + contain);
    return contain;
  }//end checkListBlasted
  
  public static void removeFromBlast(location locate){
    location target = null;
    for(location loc: blastingLocs){
      if(loc.x == locate.x 
        && loc.y == locate.y){
        target = loc;
      }
    }
    if(target != null){
      blastingLocs.remove(target);
    }
  }
  
  public static void addToBlast(location loc){
    //if(!checkBlastingLoc(loc))
      blastingLocs.add(loc);
      //println(loc.x + " " + loc.y);
  }
  
  public static int duplicatedBlast(location loc){
    int count = 0;
    for(location locate : blastingLocs){
      if(loc.x == locate.x && loc.y == locate.y){
        //println(loc.x + " " + loc.y + " "+ locate.x + " " + locate.y);
        count++;
      }
    }
    //println(count);
    return count;
  }
  
}