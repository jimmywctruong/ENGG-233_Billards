void mouseClicked() 
{
  //println("click");
  shoot_if();
}

void mouseWheel(MouseEvent event)
{
  power -= 5*event.getCount();
  println(power);
}

void shoot_if()
{
  float adj, opp, hyp;

  adj = table.cue_ball.center.x - mouseX;
  opp = table.cue_ball.center.y - mouseY;
  hyp = distance(mouseX, mouseY, 
                 table.cue_ball.center.x, table.cue_ball.center.y);
                 
  if (hyp < table.cue_ball.rad)
  {
    //println("shooting!");

    //  x_vel = power*cos(angle)
    table.cue_ball.x_vel = power*adj/hyp;
    //  y_vel = power*sin(angle)
    table.cue_ball.y_vel = power*opp/hyp;
  }
}

float distance(float x1, float y1, float x2, float y2)
{
  return sqrt(  (y2 - y1)*(y2 - y1) + (x2 - x1)*(x2 - x1)  );
}