class Stick
{
  Point start_p;
  Point end_p;
  color col; //color of the pool stick
  int length; //length of the pool stick
  //More code


  Stick (int len)
  {
    start_p = new Point(mouseX, mouseY);
    end_p = new Point(0, 0);
    col = 0;
    length = len;
  }

  void display()
  {
    calculate_points();
    line(start_p.x, start_p.y, end_p.x, end_p.y);
  }
  void calculate_points()
  {

    float adj = mouseX - table.cue_ball.center.x;
    float opp = mouseY - table.cue_ball.center.y;
    float hyp = distance(mouseX, mouseY, table.cue_ball.center.x, table.cue_ball.center.y);
    
    col = color(power/25.0*255, 0, 0);
    stroke(col);
    if (hyp <= table.cue_ball.rad)
    {
      strokeWeight(5);

      start_p.x = mouseX;
      start_p.y = mouseY;
      end_p.x = mouseX + length*adj/hyp;
      end_p.y = mouseY + length*opp/hyp;
      
    }  else {
      strokeWeight(3);
      start_p.x = mouseX + length*adj/hyp/4;
      start_p.y = mouseY + length*opp/hyp/4;
      end_p.x = mouseX + length*adj/hyp*1.25;
      end_p.y = mouseY + length*opp/hyp*1.25;
    }
  }
}
class Point
{
  float x, y;
  Point ()
  {
  }
  Point (float a, float b)
  {
    x = a;
    y = b;
  }
}