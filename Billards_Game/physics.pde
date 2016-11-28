void physics ()
{
  // loop ball physics check
  move_balls();
  
  
}

void move_balls()
{
  for (int i = 0; i < table.b_arr.length; i++)
  {
    table.b_arr[i].move();
    
    
  }
  
  
}