/**
blocks class tracking all the locations for blocks
*/
public static class blocks{
  public static ArrayList<block> blockList = new ArrayList<block>();
  
  public static boolean checkContainLoc(location loc){
    boolean contain = false;
    for(block obj: blockList){
      if(obj.getLoc().getX() == loc.getX() 
        && obj.getLoc().getY() == loc.getY()){
        contain = true;
      }
    }
    
    return contain;
  }//end checkListBlasted
  
  public static boolean checkContainLoc(int x, int y){
    boolean contain = false;
    for(block obj: blockList){
      if(obj.getLoc().getX() == x 
        && obj.getLoc().getY() == y){
        contain = true;
      }
    }
    
    return contain;
  }//end checkListBlasted
}