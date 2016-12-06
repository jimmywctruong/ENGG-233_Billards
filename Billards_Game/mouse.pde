void mouseClicked() 
{
  //println("click");
  shoot_if();
}

void mouseWheel(MouseEvent event)
{
  power -= 1*event.getCount();
  if(power < 0)
  {
    power = 0;
  } else if ( power > 30)
  {
    power = 30;
  }
  println(power);
}

void shoot_if()
{
  float adj, opp, hyp;
  table.cue_ball.contact_point.x = mouseX;
  table.cue_ball.contact_point.y = mouseY;
  
  adj = table.cue_ball.center.x - mouseX;
  opp = table.cue_ball.center.y - mouseY;
  hyp = distance(mouseX, mouseY, 
                 table.cue_ball.center.x, table.cue_ball.center.y);
                 
  if (hyp <= table.cue_ball.rad)
  {
    cue_hit.play(0);

    //  x_vel = power*cos(angle)
    table.cue_ball.x_vel = power*adj/hyp;
    //  y_vel = power*sin(angle)
    table.cue_ball.y_vel = power*opp/hyp;
  }
}
float distance(float x1, float y1, float x2, float y2)
{
  return sqrt((y2 - y1)*(y2 - y1) + (x2 - x1)*(x2 - x1));
}