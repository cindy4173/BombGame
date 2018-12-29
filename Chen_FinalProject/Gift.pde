//create gift class
class Gift
{
  //create fields
  PVector pos;
  PImage photo;
  
  //default constructor
  Gift()
  {
    pos.x = width/2;
    pos.y = height/2;
    photo = loadImage("gift.png");
  }
  
  //constructor with parameters
  Gift(PVector _pos, PImage _photo)
  {
    pos = _pos;
    photo = _photo;
  }

  // display()
  // Params: none
  // Returns: none
  // display method to draw gift
  void display()
  {
    imageMode(CENTER);
    image(photo, pos.x, pos.y);
  }

  // move()
  // Params: none
  // Returns: none
  // display method to draw gift
  void move(float speed)
  {
    pos.add(0, speed);
  }
}