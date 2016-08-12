/*
author:s5048218@gmail.com
update:2016/08/12
*/
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

PImage backGround1, backGround2, gameStart;
PImage enemy;
PImage fighter;
PImage hp;
PImage treasure;
PImage start1, start2;
PImage end1, end2;

int gameState;
int backGroundPosition_1 = 0, backGroundPosition_2 = -641 ;
int enemyPosition_x= 0, enemyPosition_y, enemySpeed_x = 0, enemySpeed_y = 0;
int blood = 20, coefficient = 2, bloodWidth;
int treasurePosition_x, treasurePosition_y;
int fighterPosition_x = 589, fighterPosition_y = 214;
int team = 1;

boolean upPressed = false, downPressed = false; 
boolean rightPressed = false, leftPressed = false; 

void setup () {
  size(640,480) ; 
  
  backGround1 = loadImage("img/bg1.png");
  backGround2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  
  //gameState = GAME_START;
  gameState = GAME_RUN; //for this week
}

void draw() {
  switch(gameState){
   case GAME_START:
     enemyPosition_y = floor(random(419));
     fighterPosition_x = 588;
     treasurePosition_x = floor(random(110, 600));
     treasurePosition_y = floor(random(440));
     blood = 20;
     image(start2, 0, 0);
     if(mouseX >= 214 && mouseX <= 428 && 
        mouseY >= 380 && mouseY <= 410){
          image(start1, 0, 0);
          if(mousePressed)
            gameState = GAME_RUN;
        }
     break;
     
   case GAME_RUN:   
     //backGround1
     backGroundPosition_1 += 1;
     if(backGroundPosition_1 == 641){
       backGroundPosition_1 = -640;
     }
     image(backGround1, backGroundPosition_1, 0);
     
     //backGround2
     backGroundPosition_2 += 1 ;
     if(backGroundPosition_2 == 641){
       backGroundPosition_2 = -641;
     }
     image(backGround2, backGroundPosition_2, 0);
     
    //enrmy
     enemySpeed_x += 5;
     if(team == 1)
       team1();
     if(team == 2)
       team2();
     if(team == 3)
       team3();
     
     //fighter
     fighterPositionMove_x();
     fighterPositionMove_y();
     fighterMax_x();
     fighterMax_y();
     
     //hitEnemy
     //hitEnemy(); //do not need this 
     image(fighter, fighterPosition_x, fighterPosition_y);
     
     //blood+treasure
     fill(255, 0, 0);
     getTreasure();
     calculateBlood();
     rect(10, 5, bloodWidth, 20 );
     image(treasure, treasurePosition_x, treasurePosition_y);
     
     //hp
     image(hp, 0 ,0);
     //game over
     
     if(blood <= 0)
       gameState = GAME_OVER;
     break;
     
     case GAME_OVER:
       image(end2, 0, 0);
       if(mouseX >= 215 && mouseX <= 430 && 
          mouseY >= 315 && mouseY <= 344){
            image(end1, 0, 0);
            if(mousePressed)
              gameState = GAME_START;
       }
       break;  
  }
}

void keyPressed(){
 if (key == CODED){
  switch( keyCode ){
   case UP:
   upPressed = true;
   break; 
   case DOWN:
   downPressed = true;
   break;
   case LEFT:
   leftPressed = true;
   break;
   case RIGHT:
   rightPressed = true;
   break;
  }
 }
}

void keyReleased(){
 if (key == CODED){
  switch( keyCode ){
   case UP:
   upPressed = false;
   break; 
   case DOWN:
   downPressed = false;
   break;
   case LEFT:
   leftPressed = false;
   break;
   case RIGHT:
   rightPressed = false;
   break;
  }
 }
}

int fighterPositionMove_x(){
  if(rightPressed) 
    fighterPosition_x += 6;
  if(leftPressed)
    fighterPosition_x -= 6;
  
   return fighterPosition_x;
}

int fighterPositionMove_y(){
  if(upPressed)
    fighterPosition_y -= 6;
  if(downPressed)
    fighterPosition_y += 6;
    
  return fighterPosition_y;
}

int fighterMax_x(){
  if(fighterPosition_x >= 589)
    fighterPosition_x = 589;
  if(fighterPosition_x <= 0)
    fighterPosition_x = 0;
  
  return fighterPosition_x;
}

int fighterMax_y(){
  if(fighterPosition_y >= 429)
    fighterPosition_y = 429;
  if(fighterPosition_y <= 0)
    fighterPosition_y = 0;
  
  return fighterPosition_y;
}

int calculateBlood(){
  bloodWidth = blood * coefficient;
  
  return bloodWidth;
}

int getTreasure(){
  if(fighterPosition_x >= treasurePosition_x - 40 &&
     fighterPosition_x <= treasurePosition_x + 40 &&
     fighterPosition_y >= treasurePosition_y - 40 &&
     fighterPosition_y <= treasurePosition_y + 40){
       blood += 10;
       treasurePosition_x = floor(random(110,600));
       treasurePosition_y = floor(random(440));
     }
    if(blood >= 100)
      blood = 100;
      
  return blood;
}

int enemySpeed(){
  enemyPosition_y += (fighterPosition_y - enemyPosition_y)/20;
  
  return enemyPosition_y;
}

int hitEnemy(){
  if(enemyPosition_x >= fighterPosition_x - 55 &&
     enemyPosition_x <= fighterPosition_x + 50 &&
     enemyPosition_y >= fighterPosition_y - 55 &&
     enemyPosition_y <= fighterPosition_y + 50 ){
     blood -= 20; 
     enemyPosition_x = 0;
     enemyPosition_y = floor(random(419));
     }
     
  return blood;
}

int team1(){
  enemyPosition_x = enemySpeed_x;
  for(int i = 0; i < 5; i++ ){
      image(enemy, enemyPosition_x, enemyPosition_y);
       enemyPosition_x -= 64;   
  }
  if(enemySpeed_x == 900){
      team = 2;
      enemySpeed_x = 0;
      enemySpeed_y= floor(random(0,250));
   }  
  return team;
}

int team2(){
  enemyPosition_x = enemySpeed_x;
  enemyPosition_y = enemySpeed_y;
  for(int i = 0; i < 5; i++ ){    
      image(enemy, enemyPosition_x, enemyPosition_y);
       enemyPosition_x -= 64;
       enemyPosition_y += 40;
  }
  if(enemyPosition_x == 640){
      team = 3;
      enemySpeed_x = 0;
      enemySpeed_y= floor(random(128,320));
  }  
  return team;
}

int team3(){
  enemyPosition_x = enemySpeed_x;
  enemyPosition_y = enemySpeed_y;    
  image(enemy, enemyPosition_x, enemyPosition_y);
  image(enemy, enemyPosition_x-64, enemyPosition_y+64);
  image(enemy, enemyPosition_x-64, enemyPosition_y-64);
  image(enemy, enemyPosition_x-128, enemyPosition_y+128);
  image(enemy, enemyPosition_x-128, enemyPosition_y-128);
  image(enemy, enemyPosition_x-192, enemyPosition_y+64);
  image(enemy, enemyPosition_x-192, enemyPosition_y-64);
  image(enemy, enemyPosition_x-256, enemyPosition_y);
  
  if(enemyPosition_x == 900){
      team = 1;
      enemySpeed_x = 0;
      enemySpeed_y= floor(random(419));
  }  
  return team;
}
