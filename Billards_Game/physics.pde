void physics ()
{
  // ball physics looped by draw
  
  move_balls();
  check_pockets();
  check_collisions();
  
}
void check_pockets()
{
  table.cue_ball.check_pockets();
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].check_pockets();

  }
}
void check_collisions()
{
  table.cue_ball.check_wall_collisions();
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].check_wall_collisions();

  }
}

void move_balls()
{
  table.cue_ball.move();
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].move();
    
  }
}