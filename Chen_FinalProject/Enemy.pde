//create enemy class
class Enemy
{
  //create fields
  PVector pos;
  PImage photo;
  
  //default constructor
  Enemy()
  {
    pos.x = width/2;
    pos.y = height/2;
    photo = loadImage("enemy.png");
  }
  
  //second constructor with parameters
  Enemy(PVector _pos, PImage _photo)
  {
    pos = _pos;
    photo = _photo;
  }
  
  // display()
  // Params: none
  // Returns: none
  // display method to draw enemy
  void display()
  {
    imageMode(CENTER);
    image(photo, pos.x, pos.y);
  }
  
  // move()
  // Params: speed of enemy
  // Returns: none
  // move enemy
  void move(float speed)
  {
    pos.add(0, speed);
  }
}