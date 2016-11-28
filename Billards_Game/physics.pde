void physics ()
{
  // loop ball physics check
  move_balls();
  check_collisions();
  
}

void check_collisions()
{
  
  
  
}

void move_balls()
{
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].move();
    
    
  }
  
  table.cue_ball.move();
  
}