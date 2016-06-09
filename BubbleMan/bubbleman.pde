/**
main file for the game, 
*/

agent player;
AI enemy;
AI enemy2;
AI enemy3;
int up = 1, down = 2, left = 3, right = 4, startTime, timeNow;

boolean gameOver, win;
boolean moved;
boolean dodging;

gridcell AI;
gridcell target;
ArrayList<gridcell> path;

ArrayList<location> dangerLocs;

void settings(){
  size(600, 520);
}
void setup() {
  loadChests();
  loadBlocks();
  loadAgents();
  initMap();
  gameOver = false;
  win = false; 
  moved = false;
  timeNow = 0;
  startTime = 0;

  //testing
  /*
  AI = new gridcell(new location (enemy.x, enemy.y));
  target = new gridcell(new location (player.x, player.y));
  path = new pathfinding(AI, target).Astar();*/
  allLocations.initOpenLocs();
  allLocations.initSaveLocs();
  //dangerLocs = new AI().getDangerAreas();
}

void update(){
  //testing
  /*
  AI.loc.x = enemy.x;
  AI.loc.y = enemy.y;
  target.loc.x = player.x;
  target.loc.y = player.y;
  path = new pathfinding(AI, target).Astar();  */
  //allLocations.calOpenLocs();
  //dangerLocs = new AI().getDangerAreas();

  enemy.makeDecision();
  enemy2.makeDecision();
  enemy3.makeDecision();
  //println("after Decision");
  checkGameOver();
}

void draw() {
  update();
  //
  background(0,200,0);
  
  drawBlocks();
  drawChests();
  drawItems();
  drawBubbles();
  drawAgents();
  
  //test
  //drawpath();
  drawDangers();
  
  
  if(gameOver){
    textSize(32);
    fill(255, 40, 40);
    text("GAME OVER!!", width/2 -100, height/2);  
  }
  else if(win){
    textSize(32);
    fill(40, 40, 255);
    text("WIN!!", width/2 -40, height/2);  
  }
}

void keyPressed() {
  if(key == CODED){
    if(keyCode == UP)
      player.move(1);
    else if (keyCode == DOWN)
      player.move(2);
    else if (keyCode == LEFT)
      player.move(3);
    else if (keyCode == RIGHT)
      player.move(4);
  }
  else if(key == ' '){
    player.dropBubble();
  }
}

void loadAgents(){
  PImage playerImg = loadImage("playerAgent.png");
  PImage enemyImg = loadImage("enemy.png");
  PImage enemyImg2 = loadImage("enemy2.png");
  PImage enemyImg3 = loadImage("enemy3.png");
  player = new agent(40, 40, playerImg);
  enemy = new AI(width -80, height - 80, enemyImg, "enemy1"); 
  enemy2 = new AI(40, height - 80, enemyImg2, "enemy2"); 
  enemy3 = new AI(width -80, 40, enemyImg3, "enemy3"); 
  agents.allAgents.add(player);
  agents.allAgents.add(enemy);
  agents.allAgents.add(enemy2);
  agents.allAgents.add(enemy3);
  agents.myPlayer = player;
  
}

//chests locations
void loadChests(){  
    //chests.chestList.add(new chest(new location(width -160, height - 80))); //test
    for(int k = 40; k < width-40; k+=80){
      for(int l = 80; l < height - 80; l+=40) {
        if(k == 40 || k == width-80) {
          if(l > 80 && l < 400) {
            location tempLoc = new location(k,l);
            chest chestObj = new chest(tempLoc);
            if(!chests.checkContainLoc(tempLoc)){
              chests.chestList.add(chestObj);
            }
          }
        } //end if k==40
        else {
          location tempLoc = new location(k,l);
          chest chestObj = new chest(tempLoc);
            if(!chests.checkContainLoc(tempLoc)){
              chests.chestList.add(chestObj);
            }
        }//end else k!= 40
      }//height loop
    }//width loop 
}

//blocks locations
void loadBlocks(){
  
  for(int i = 0; i < width; i+=40) {
      location tempLoc = new location(i, 0);
      block blockObj = new block(tempLoc);
      if(!blocks.checkContainLoc(tempLoc)){
          blocks.blockList.add(blockObj);
      }
      tempLoc = new location(0,i);
      blockObj = new block(tempLoc); 
      if(!blocks.checkContainLoc(tempLoc)){
          blocks.blockList.add(blockObj);
      }
  }//end for loop
  
  for(int j = width; j > 0; j-=40) {
    location tempLoc = new location(560,j);
    block blockObj = new block(tempLoc);
    if(!blocks.checkContainLoc(tempLoc)){
      blocks.blockList.add(blockObj);
    }
    tempLoc = new location(j,480);
    blockObj = new block(tempLoc);
    if(!blocks.checkContainLoc(tempLoc)){
      blocks.blockList.add(blockObj);
    }
  }//end for loop
  
  for(int k = 80; k < height; k+=80) {
    for(int l = 80; l < width - 80; l+=80) {
      location tempLoc = new location(k,l);
      block blockObj = new block(tempLoc);
      if(!blocks.checkContainLoc(tempLoc)){
        blocks.blockList.add(blockObj);
      }
    }
  }//end for loop
}//end load blocks


//setup locations for all cells, locations
public void initMap(){
  for(int i = 0; i < width; i+=40) {
    for(int j = 0; j < height; j+=40){
      location loc = new location(i,j);
      allLocations.mapLocations.add(loc);
      gridcell cell = new gridcell(loc);
      mapcells.allcells.add(cell);
    }
  }
  
  mapcells.fillBlocked();
//end for loop
}

//testing if all loc covered
void cellsdraw(){
  for(gridcell c : mapcells.allcells){
    location loc = c.loc;
    ellipseMode(CORNER);
    ellipse(loc.x, loc.y, 30, 30);
  }
}

void drawpath(){
  /*boolean ispath = false;
  if(count == 1){
    println(path.size() + "length");
    count --;
  }*/
  
  for(gridcell pc : path){
      fill(0, 0, 100);
      ellipseMode(CORNER);
      ellipse(pc.loc.x, pc.loc.y, 30, 30);
  }//end of path 
  
}//end function drawpath
  
  
//bubbles drawing
void drawBubbles(){
  for(agent ag : agents.allAgents){
    for(bubble bb : ag.getBubbles()){
      if(bb.isDropped()){
        if(bb.getTimer() > 0){
          //println("timer: " + bb.getTimer());
           bb.draw();
           bb.update();
        }
        else{
          //println("blast condition");
          bb.blast();
        }
      }// if dropped end
      //blasting anime
      if(bb.isBlasting()){
        bb.drawBlast();
        if(bb.getBlastTimer() <= 0){
          bb.finishBlast();
        }
        else{
          bb.blastUpdate();
        }
      }//if blasting
    }//bubble loop end
  }//agents loop end
  /*
  for(bubble bb : enemy.getBubbles()){
    if(bb.isDropped()){
      if(bb.getTimer() > 0){
        //println("timer: " + bb.getTimer());
         bb.draw();
         bb.update();
      }
      else{
        //println("blast condition");
        bb.blast();
      }
    }// if dropped end
    //blasting anime
    if(bb.isBlasting()){
      bb.drawBlast();
      if(bb.getBlastTimer() <= 0){
        bb.finishBlast();
      }
      else{
        bb.blastUpdate();
      }
    }//if blasting
  }//bubble loop end */
}

void drawChests(){
  for(int i=0; i< chests.chestList.size(); i++){
    chests.chestList.get(i).draw();
  }
}

void drawBlocks(){
  for(int i=0; i< blocks.blockList.size(); i++){
    blocks.blockList.get(i).draw();
  }
}

void drawItems(){
  for(int i=0; i< items.itemList.size(); i++){
    items.itemList.get(i).draw();
  }
}

void drawAgents(){
  for(int i=0; i< agents.allAgents.size(); i++){
    agent ag = agents.allAgents.get(i);
    if(ag.isAlive()){
      ag.draw();
    }
    else{
      ag.drawDied();
    }
  }
}//end drawAgent

//test danger area draw
void drawDangers(){
  //println("danger size: " + dangerLocs.size());
  for(int i=0; i< enemy.sortedSaves.size(); i++){
    location loc =enemy.sortedSaves.get(i);
    textSize(20);
    fill(300, 200, 100);
    ellipseMode(CORNER);
    //ellipse(loc.x, loc.y, 30, 30);
    text(" "+ i, loc.x, loc.y + 20);
    //println(loc.x + " " + loc.y);
  }
}

void checkGameOver(){
  if(!player.isAlive())
    gameOver = true;
  else if(!enemy.isAlive() && !enemy2.isAlive() && !enemy3.isAlive())
    win = true;
  
}