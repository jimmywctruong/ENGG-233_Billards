void draw() 
{

  table.draw();
  draw_lines();
  
  physics();
  //println(table.cue_ball.x_vel, table.cue_ball.y_vel);
}