/************************************************************
* Static Items class to hold all the items and easily access*
* each item                                                 *
* Also to check if the location contains an item            *
************************************************************/
public static class items{
  public static ArrayList<item> itemList = new ArrayList<item>();
  
  public static boolean checkContainLoc(location loc){
    boolean contain = false;
    for(item it: itemList){
      if(it.getLoc().getX() == loc.getX() 
        && it.getLoc().getY() == loc.getY()){
        contain = true;
      }
    }
    return contain;
  }//end checkListBlasted
  
  public static item getContainItem(location loc){
    item target = null;
    for(item it: itemList){
      if(it.getLoc().getX() == loc.getX() 
        && it.getLoc().getY() == loc.getY()){
        target = it;
      }
    }
    return target;
  }
  
}