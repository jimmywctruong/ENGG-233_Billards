class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;

  float x_vel;
  float y_vel;

  Ball (float r, float x, float y, color co)
  {
    rad = r;
    center = new Point (x, y);
    col = co;

    x_vel = 0;
    y_vel = 0;
  }

  void move()
  {
    center.x += x_vel;
    center.y += y_vel;
    
    //if (xvel > friction)
    //{
    //  center.x += x_vel;
    //  x_vel -= friction;
    //}
    //if (y_vel > friction)
    //{
    //  center.y += y_vel;
    //  y_vel -= friction;
    //}
  }
  boolean is_moving()
  {
    if ((x_vel !=0) || (y_vel != 0))
    {
      return true;
    }
    return false;
  }
  
  void display () 
  {
    fill(col);
    stroke (0);
    strokeWeight(3);
    ellipse (center.x, center.y, rad*2, rad*2);
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
class Point
{
  float x, y;
  Point (float a, float b)
  {
    x = a;
    y = b;
  }
}