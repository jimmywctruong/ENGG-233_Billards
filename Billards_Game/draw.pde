void draw() 
{

  table.draw();
  draw_tools();
  
  physics();
  
  if(game_over)
  {
    game_over();
  }
  //println(table.cue_ball.x_vel, table.cue_ball.y_vel);
}

void game_over ()
{
  println("Game Over");
  frameRate(0);
}