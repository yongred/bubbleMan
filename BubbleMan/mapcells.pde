

public static class mapcells{
  public static ArrayList<gridcell> allcells = new ArrayList<gridcell>();
  
  public static void fillBlocked(){
    for(gridcell c: allcells){
      // || chests.checkContainLoc(c.loc)
      if(blocks.checkContainLoc(c.loc) || chests.checkContainLoc(c.loc) || bubblesdropped.checkContainLoc(c.loc)){
        c.blocked = true;
        
      }
      else{
        c.blocked = false;
        //println(c.loc.x + " " + c.loc.y + " blocked " +c.blocked);
      }
    }
    
  }//end fillblocked
  
  public static gridcell getContainCell(location loc){
    gridcell target = null;
    for(gridcell cell: allcells){
      if(cell.loc.getX() == loc.getX() 
        && cell.loc.getY() == loc.getY()){
        target = cell;
      }
    }
    return target;
  }
  
}//end mapcells