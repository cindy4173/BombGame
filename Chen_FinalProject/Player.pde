//create player class
class Player
{
  //create fields
  PVector pos;
  PImage photo1;
  PImage photo2;
  
  //default constructor
  Player()
  {
    pos.x = width/2;
    pos.y = height/2;
    photo1 = loadImage("player.png");
    photo2 = loadImage("player2.png");
  }
  
  //constructor with parameters
  Player(PVector _pos, PImage _photo1, PImage _photo2)
  {
    pos = _pos;
    photo1 = _photo1;
    photo2 = _photo2;
  }
  
  // display()
  // Params: none
  // Returns: none
  // display method to draw player
  void display()
  {
    imageMode(CENTER);
    image(photo1, pos.x, pos.y);
  }
  
  // display2()
  // Params: none
  // Returns: none
  // display method to draw other player
  void display2()
  {
    imageMode(CENTER);
    image(photo2, pos.x, pos.y);
  }
}