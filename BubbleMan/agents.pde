/**
agents record all agents playing
*/

public static class agents{
  public static ArrayList<agent> allAgents = new ArrayList<agent>();
  public static agent myPlayer;
  public static boolean checkContainLoc(location loc){
    boolean contain = false;
    for(agent ag: allAgents){
      if(ag.getX() == loc.getX() 
        && ag.getY() == loc.getY()){
        contain = true;
      }
    }
    return contain;
  }//end checkListBlasted
  
  //get agent with this location
  public static agent getContainAgent(location loc){
    agent target = null;
    for(agent ag: allAgents){
      if(ag.getX() == loc.getX() 
        && ag.getY() == loc.getY()){
        target = ag;
      }
    }
    return target;
  }
}