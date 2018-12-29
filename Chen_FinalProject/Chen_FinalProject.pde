//name: Sitong Chen

//create three objects
Player playerObj;
Enemy[] enemyObj;
Gift[] giftObj;

PImage player1;
PImage player2;
PImage enemy;
PImage gift;

PImage HUD;
PImage GameOver;

//create PVectors to get the position of elements
PVector[] enemyPos;
PVector[] giftPos;
PVector playerPos;

//define the number of enemy and number of Gift
int numberEnemy;
int numberGift;

//create float arrays to check the distance between elements and player
float[] enemyDis;
float[] giftDis;

//create booleans to check if player still live and get gidts
boolean checkLive = true;
boolean checkScore = true;

//create boolean to change method from player class, in order to change the player
boolean ifDisplay2 = false;

//create a int data to hold the number of gifts that player got
int countScore = 0;
void setup()
{
  HUD = loadImage("HUD.jpg");
  GameOver = loadImage("GameOver.jpg");
  size(500, 500);     //size of window
  
  //load images
  player1 = loadImage("player.png");
  player2 = loadImage("player2.png");
  enemy = loadImage("enemy.png");
  gift = loadImage("gift.png");
  //set the number of enemy and gift
  numberEnemy = 7;
  numberGift = 20;
  
  enemyObj = new Enemy[numberEnemy];    //define enemy objects array
  enemyPos = new PVector[numberEnemy];   //define postion checking PVector array
  giftObj = new Gift[numberGift];     //define gift object array
  giftPos = new PVector[numberGift];   //define postion checking PVector array
  
  //assign data to enemy object
  for(int i = 0; i < numberEnemy; i++)
  {
    enemyPos[i] = new PVector(random(30, 470), random(30, height));
    enemyObj[i] = new Enemy(enemyPos[i], enemy);
  }
  //assign data to gifts object
  for(int i = 0; i < numberGift; i++)
  {
    giftPos[i] = new PVector(random(15, 460), random(15, height));
    giftObj[i] = new Gift(giftPos[i], gift);
  }
  
  //define enemy and gift distance arrays
  enemyDis = new float[numberEnemy];    
  giftDis = new float[numberGift];   
}

//set variables for fame counter
int frameCounter = 0;
int currentFrame = 0;
//set boolean variable to check time
boolean checkTime = true;
void draw()
{  
  //define the position of player
  playerPos = new PVector(mouseX, 450);  
  //call two functions to display the elements
  checkEnemyDis();
  checkGiftDis();
  //check time in order to increase the difficulty
  if(frameCounter < 600)
  {
    checkEnemy(0.7);
    checkGift(0.2);
  }
  if(frameCounter >= 600 && frameCounter < 1200)
  {
    checkEnemy(0.8);
    checkGift(0.3);
  }
  if(frameCounter >= 1200 && frameCounter < 2000)
  {
    checkEnemy(0.9);
    checkGift(0.4);
  }
  if(frameCounter >= 2000 && frameCounter < 2600)
  {
    checkEnemy(1);
    checkGift(0.5);
  }
  if(frameCounter >= 2600 && frameCounter < 3100)
  {
    checkEnemy(1.2);
    checkGift(0.6);
  }
  if(frameCounter >= 3100 && frameCounter < 3700)
  {
    checkEnemy(1.4);
    checkGift(0.7);
  }
  if(frameCounter >= 3700 && frameCounter < 4300)
  {
    checkEnemy(2);
    checkGift(0.8);
  }
  if(frameCounter >= 4300)
  {
    checkEnemy(2.3);
    checkGift(0.9);
  }
  
  //if checkTime is true, increasing one frame
  if(checkTime)
  {
    frameCounter+=1;
    currentFrame = frameCounter;
  }    
  //println(currentFrame);   //print frame 
    
  //update the condition. 
  //if elements out of window, it would roll back with random position
  for(int i = 0; i < numberEnemy; i++)
  {
    if (enemyObj[i].pos.y > height)
    {
      enemyPos[i].set(random(30, 460), random(-height, -30));
    }
  }
  for(int i = 0; i < numberGift; i++)
  {
    if (giftObj[i].pos.y > height)
    {
      giftPos[i].set(random(15, 460), random(-height, -15));
    }
  }
  //call eating function to eat emelents by player
  eating();
  
  //write text on left top of window to show the score that player got
  fill(255);
  textSize(15);
  text("time: " + currentFrame/60, 15, 20);
  text("gifts: " + countScore, 15, 35);
  //println(countScore);
}

void mouseClicked()
{
  //if mouse clicked, the game will restart and data will back to 0
  checkTime = true;
  checkLive = true;
  checkScore = true;  
  ifDisplay2 = false;
  frameCounter = 0;
  countScore = 0;
}

void keyPressed()
{
  //press b key to change to second player method display2
  if(key == 'b')
  {
    ifDisplay2 = true;
    checkLive = true;
    checkScore = true; 
  }
  //press a key to change back to first player method display
  if(key == 'a')
  {
    ifDisplay2 = false;
    checkLive = true;
    checkScore = true; 
  }  
}

// checkEnemyDis()
// Params: none
// Returns: none
// check the distance between enemy and player
void checkEnemyDis()
{
  for(int i = 0; i < numberEnemy; i++)
  {
    enemyDis[i] = playerPos.dist(enemyPos[i]);
    //println(enemyDis);
  }
}
// checkGiftDis()
// Params: none
// Returns: none
// check the distance between gift and player
void checkGiftDis()
{
  for(int i = 0; i < numberGift; i++)
  {
    giftDis[i] = playerPos.dist(giftPos[i]);
    //println(giftDis);
  }
}

// checkEnemy()
// Params: none
// Returns: none
// check the if player still live and call display methods
void checkEnemy(float speed)
{
  //if player still live(distance between enmey and player is larger than 40)
  if(checkLive)
  {
    for(int i = 0; i < numberEnemy; i++)
    {
      if(enemyDis[i] > 40)
      {
        background(HUD);
        //call the player first method if second display is false
        //and call enemy methods to show and move the enemy
        if(ifDisplay2 == false)
        {
          for(int j = 0; j < numberEnemy; j++)
          {
            enemyObj[j].display();
            enemyObj[j].move(speed);
            playerObj = new Player(playerPos, player1, player2);
            playerObj.display();
          }
        }
        //call the second mothod if second display is true
        //and call enemy methods to show and move the enemy
        if(ifDisplay2)
        {
          for(int j = 0; j < numberEnemy; j++)
          {
            enemyObj[j].display();
            enemyObj[j].move(speed);
            playerObj = new Player(playerPos, player1, player2);
            playerObj.display2();
          }
        }                
      }    
    }
  }     
}

// checkGift()
// Params: none
// Returns: none
// check the if player eat the gifts when player lives
void checkGift(float speed)
{
  //if checkScore is true, and the distance between player and gifts is larger than 40
  //call gift methods to show and move the gifts
  if(checkScore)
  {
    for(int i = 0; i < numberGift; i++)
    {
      if(giftDis[i] > 40)
      {
        for(int j = 0; j < numberGift; j++)
        {
          giftObj[j].display();
          giftObj[j].move(speed);          
        }
      }    
    }
  }
}

// eating()
// Params: none
// Returns: none
// check the if player eat the gifts or enemy
void eating()
{
  //if the distance between enemy and player is smaller than 40, player is die
  for(int i = 0; i < numberEnemy; i++)
  {
    if (enemyDis[i] <= 40)
    {
      checkLive = false;
      checkScore = false;
      checkTime = false;
      background(GameOver);     //change the background
      fill(255);
      textSize(40);
      text("GAME OVER", width/4, height/2);
      textSize(20);
      text("Click to restart game...", width/4, height/2+40);
      //set enemy position out of window
      enemyPos[i].set(random(30, 460), random(-height, -30));
    }
  }
  //if the distance between gift and player is smaller than 40, gift was eaten
  for(int i = 0; i < numberGift; i++)
  {
    if (giftDis[i] <= 40)
    {
      //set the gift position out of window and rolling down again
      giftPos[i].set(random(15, 460), random(-height, -15));
      //count the number of gifts that user got
      countScore = countScore + 1;
    }
  }  
}
  