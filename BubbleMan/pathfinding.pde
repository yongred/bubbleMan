
class pathfinding{
  
  gridcell start;
  gridcell target;
  public pathfinding(gridcell start, gridcell target){
    this.start = start;
    this.target = target;
  }
  
  public int manhDis(gridcell str, gridcell end){
    
    return (abs(str.loc.x - end.loc.x) +  abs(str.loc.y - end.loc.y)) / 40;
  }
  
  public ArrayList<gridcell> Astar(){
    //ArrayList<gridcell> path = null;
    ArrayList<gridcell> opens = new ArrayList<gridcell>();
    ArrayList<gridcell> closes = new ArrayList<gridcell>();
    start.G = 0;
    start.H = manhDis(start, target);
    start.F = start.G + start.H;
    
     //ArrayList<gridcell> copyOpen = new ArrayList<gridcell>(opens);
    gridcell cur = start;
    opens.add(cur);
    
    while(opens.size() != 0){
      cur = lowestF(opens);
      
      
      if(cur.loc.x == target.loc.x && cur.loc.y == target.loc.y){
        //println("makepath size: " + makepath(cur).size());
        
        return makepath(cur);
      }

      //println("current x :" + cur.loc.x + " y: " + cur.loc.y);
      //println("target x " + target.loc.x + " y " + target.loc.y);
      opens.remove(cur);
      closes.add(cur);
      //set neighbors values
      //println("nb size: " + neighbors(cur).size());
      for(gridcell nb : neighbors(cur)){
        if(!closes.contains(nb)){
          nb.H = manhDis(nb, target);
          nb.F = nb.G + nb.H;
          
          gridcell nbInOpens = containCell(nb, opens);
          gridcell nbInCloses = containCell(nb, closes);
          //println("nbIn par outside: " + nbInOpens + " " +"x :" + cur.loc.x + " y: " + cur.loc.y + " size " + opens.size());
          if(nbInOpens == null && nbInCloses == null){
            
            opens.add(nb);
            //println("nbIn par outside: " + opens.size());
          }else if(nbInOpens != null && nbInCloses == null){
            //println("nb G: " + nb.G + " nbIn G: " + nbInOpens.G);
             if(nb.G < nbInOpens.G){
               nbInOpens.G = nb.G;
               nbInOpens.parent = nb.parent;
               //println("nbIn par: " + nbInOpens.parent);
             }
             //println("nbIn par outside: " + nbInOpens);
          }
          
        }//close contain nb
      }//end of neighbors loop
      
    }//end of  opens loop
    //println("outside size: " + opens.size());
    return null;
  }//end of Astar
  
  //find the lowest Fcost in list
  public gridcell lowestF(ArrayList<gridcell> cells){
    gridcell minC = cells.get(0);
    for(gridcell c : cells){
      if(c.F < minC.F)
        minC = c;
    }
    
    return minC;
  }
  
  //find 8 neighbors
  public ArrayList<gridcell> neighbors(gridcell curCell){
    ArrayList<gridcell> neighbors = new ArrayList<gridcell>();
    
    for(gridcell c: mapcells.allcells){
      gridcell copyC = new gridcell(c);
      if(copyC.blocked){
        continue;
      }
      int x = copyC.loc.x;
      int curX = curCell.loc.x;
      int y = copyC.loc.y;
      int curY = curCell.loc.y;
      //non diagonal
      if(y == curY && x == curX - 40 ){
        copyC.G = curCell.G + 1;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(y == curY && x == curX + 40 ){
        copyC.G = curCell.G + 1;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(x == curX && y == curY - 40 ){
        copyC.G = curCell.G + 1;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(x == curX && y == curY + 40 ){
        copyC.G = curCell.G + 1;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }
      
      //diagonal
      /*
      else if(x == curX -40 && y == curY - 40 ){
        copyC.G = curCell.G + 2;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(x == curX +40 && y == curY - 40 ){
       copyC.G = curCell.G + 2;
       copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(x == curX -40 && y == curY + 40 ){
         copyC.G = curCell.G + 2;
         copyC.parent = curCell;
        neighbors.add(copyC);
      }
      else if(x == curX +40 && y == curY +40 ){
        copyC.G = curCell.G + 2;
        copyC.parent = curCell;
        neighbors.add(copyC);
      }  */
    }//end loop allcells
    
    return neighbors;
  }//end of neighbors function
  
  public ArrayList<gridcell> makepath(gridcell cell){
    ArrayList<gridcell> path = new ArrayList<gridcell>();
    path.add(cell);
    while(cell.parent != null){
      cell = cell.parent;
      path.add(cell);
    }
    return path;
  }
  
  //check if list contain gridcell
  public gridcell containCell(gridcell target, ArrayList<gridcell> list){
    for(gridcell c: list){
      if(target.loc.x == c.loc.x && target.loc.y == c.loc.y)
        return c;
    }
    
    return null;
  }
  
  public void printCells(ArrayList<gridcell> list){
    for(gridcell c: list){
      println("x :" + c.loc.x + " y: " + c.loc.y);
    }
    println("-----------------");
  }
  
  
}