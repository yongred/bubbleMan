
class gridcell{
  //boolean save;
  public location loc;
   gridcell parent;
   boolean blocked;
  int H;    //cost steps from here to target
  int G;    //cost steps from start to here
  int F;    //total cost, H + G
  //gridcell [] diagonals;
  //gridcell [] notDiags;
 
  
  public gridcell(int H, int G, int F, location loc){
    this.H = H;
    this.G = G;
    this.F = F;
    this.loc = loc;
    //save = true;
    parent= null;
  }
  
  public gridcell(location loc){
    H = Integer.MAX_VALUE;
    G = Integer.MAX_VALUE;
    F = Integer.MAX_VALUE;
    this.loc = loc;
    //save = true;
    parent= null;
  }
  
  public gridcell(location loc, boolean blocked){
    H = Integer.MAX_VALUE;
    G = Integer.MAX_VALUE;
    F = Integer.MAX_VALUE;
    this.loc = loc;
    //save = true;
    parent= null;
    this.blocked = blocked;
  }
  
  //copy constructor
  public gridcell(gridcell copyFrom){
    this.H = copyFrom.H;
    this.G = copyFrom.G;
    this.F = copyFrom.F;
    this.loc = copyFrom.loc;
    //this.save = copyFrom.save;
    this.parent = copyFrom.parent;
    this.blocked = copyFrom.blocked;
  }
  
}