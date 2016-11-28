void mouseClicked() 
{
  shoot_if();
}

void mouseWheel(MouseEvent event)
{
  power += event.getCount();
  println(power);
}

void shoot_if()
{
  if (distance(mouseX, mouseY, table.cue_ball.center.x, table.cue_ball.center.y)
    < table.cue_ball.rad)
  {
    table.cue_ball.x_vel = power*(table.cue_ball.center.x - mouseX)/distance(
      mouseX, mouseY, table.cue_ball.center.x, table.cue_ball.center.y);
      
    table.cue_ball.y_vel = power*(table.cue_ball.center.x - mouseY)/distance(
      mouseX, mouseY, table.cue_ball.center.x, table.cue_ball.center.y);
      
    println("firing!");
  }
  println("click");
}
float distance(float x1, float y1, float x2, float y2)
{

  return sqrt(  (y2 - y1)*(y2 - y1) + (x2 - x1)*(x2 - x1)  );
}