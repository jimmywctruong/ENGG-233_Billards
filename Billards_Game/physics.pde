void physics ()
{
  // loop ball physics check
   
  move_balls();
  check_pockets();
  check_collisions();
  
}
void check_pockets()
{
  
  
  
}
void check_collisions()
{
  table.cue_ball.check_wall_collisions();
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].check_wall_collisions();

  }
}
void check_vertical_walls()
{
   if (table.cue_ball.center.x < 80 + table.cue_ball.rad)
  {
    table.cue_ball.center.x = 80 + table.cue_ball.rad;
    table.cue_ball.x_vel *= -1;
  }
  if (table.cue_ball.center.x > width - (80 + table.cue_ball.rad))
  {
    table.cue_ball.center.x = width - (80 + table.cue_ball.rad);
    table.cue_ball.x_vel *= -1;
  }
  
}



void move_balls()
{
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].move();
    
    
  }
  
  table.cue_ball.move();
  
}