class Point
{
  float x, y;
  Point (float a, float b)
  {
    x = a;
    y = b;
  }
}
class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;
  //More code

  Ball (float r, float x, float y, color co)
  {
    rad = r;
    center = new Point (x, y);
    col = co;
  }

  void display () 
  {
    fill(col);
    ellipse (center.x, center.y, rad, rad);
  }
}
class Stick
{
  Point start_p;
  Point end_p;
  color col; //color of the pool stick
  int length; //length of the pool stick
  //More code
}
class Table
{
  Ball [] b_arr; //the length of this array can be 1 for
  Ball cue_ball; //iteration 3
  Stick st;
  //More code
  
  Table (int balls)
  {
    
    cue_ball = new Ball (30, 400, 400, 255);
    b_arr = new Ball [balls];
    Stick st = new Stick ();
  }
  
  void display() 
  {
    int border = 40;
    int hole = 60;
    
    fill(10, 108, 3);
    stroke(139, 69, 19);
    strokeWeight(border);
    
    draw_rect (border);

    
    
    draw_holes(hole);
    
  }
  
  void draw_holes (int hole)
  {
    stroke(0, 0);
    fill(255);
    
    ellipse(hole,         hole,          hole, hole);
    ellipse(width - hole, hole,          hole, hole);
    ellipse(hole,         height - hole, hole, hole);
    ellipse(width - hole, height - hole, hole, hole);
    
  }
  
  void draw_rect (int border)
  {
    rect(border/2, border/2, width - border, height - border);
  }
}