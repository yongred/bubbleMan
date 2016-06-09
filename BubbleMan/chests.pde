/************************************************************
* Static Chests class to easily access all the chest objects*
* Also used to check if a location contains a chest or not  *
* Remove any chests that have been blown up by a bubble     *
************************************************************/
public static class chests{
  public static ArrayList<chest> chestList = new ArrayList<chest>();
  public static boolean checkContainLoc(location loc){
    boolean contain = false;
    for(chest ch: chestList){
      if(ch.getLoc().getX() == loc.getX() 
        && ch.getLoc().getY() == loc.getY()){
        contain = true;
      }
    }
    return contain;
  }//end checkListBlasted
  
  public static boolean checkContainLoc(int x, int y){
    boolean contain = false;
    for(chest ch: chestList){
      if(ch.getLoc().getX() == x 
        && ch.getLoc().getY() == y){
        contain = true;
      }
    }
    return contain;
  }//end checkListBlasted
  
  public static chest getContainChest(location loc){
    chest target = null;
    for(chest ch: chestList){
      if(ch.getLoc().getX() == loc.getX() 
        && ch.getLoc().getY() == loc.getY()){
        target = ch;
      }
    }
    return target;
  }
  
  public static void delete(location loc){
    chest target = null;
    for(chest ch: chestList){
      if(ch.getLoc().getX() == loc.getX() 
        && ch.getLoc().getY() == loc.getY()){
        target = ch;
      }
    }
    if(target != null){
      //println("target: " + target);
      chestList.remove(target);
    }
  }
  
}//end chests class