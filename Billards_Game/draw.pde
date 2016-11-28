void draw() 
{

  table.draw();

  physics();
  println(table.cue_ball.x_vel, table.cue_ball.y_vel);
}