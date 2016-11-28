void physics ()
{
  // loop ball physics check
  move_balls();
  check_collisions(); // NEEDS TO USE TRIG
  
}

void check_collisions()
{
  check_vertical_walls();
  check_horizontal_walls();
  
}
void check_vertical_walls()
{
  if (table.cue_ball.center.x < 80 + table.cue_ball.rad)  //  Left Wall
  {
    table.cue_ball.x_vel *= -1;
    table.cue_ball.center.x = 80+table.cue_ball.rad;
  }
  if (table.cue_ball.center.x > width - (80 + table.cue_ball.rad))  //  Right Wall
  {
    table.cue_ball.x_vel *= -1;
    table.cue_ball.center.x = width - (80 + table.cue_ball.rad);
  }
  
}

void check_horizontal_walls()
{
  if (table.cue_ball.center.y < 80 + table.cue_ball.rad)  //  Top Wall
  {
    table.cue_ball.y_vel *= -1;
    table.cue_ball.center.y = 80+table.cue_ball.rad;
  }
  if (table.cue_ball.center.y > height - (80 + table.cue_ball.rad))  //  Bottom Wall
  {
    table.cue_ball.y_vel *= -1;
    table.cue_ball.center.y = height - (80 + table.cue_ball.rad);
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