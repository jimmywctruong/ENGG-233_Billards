void draw_tools()
{
  int step = 10;
  crosshairs(step);
  collide_lines();
  textSize(32);
  fill(255, 0, 0);
  text("Q" + table.cue_ball.quadrant, table.cue_ball.center.x + 2*table.cue_ball.rad, table.cue_ball.center.y - table.cue_ball.rad);
  text("(" + table.cue_ball.center.x + ", " + table.cue_ball.center.y + ")", table.cue_ball.center.x + 2*table.cue_ball.rad, table.cue_ball.center.y + 2*table.cue_ball.rad);
  rect(table.cue_ball.center.x - 1, table.cue_ball.center.y - 1, 2, 2);

  fill(0, 0);
  stroke(0, 0, 255);
  rect(border, border, 1.5*table.cue_ball.rad, 1.5*table.cue_ball.rad);
}

void collide_lines() 
{
  stroke(255, 0, 0);

  strokeWeight(2);
  fill(0, 0);
  rect(80 - 2, 80 - 2, width - 2*(80 - 1), height - 2*(80 - 1));
}
void crosshairs(int step)
{
  for (int i = 0; i < width; i+= step)  //  Horizontal
  {
    if (i/step%2 == 0)
    {
      stroke(0);
      line(i, height/2, i+step, height/2);
    }
  }

  for (int i = 0; i < height; i+= step)  //  Vertical
  {
    if (i/step%2 == 0)
    {
      stroke(255);
      line(width/2, i, width/2, i+step);
    }
  }
}