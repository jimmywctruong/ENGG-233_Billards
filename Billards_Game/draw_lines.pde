
void draw_lines()
{
  int step = 10;
  crosshairs(step);
  collide_lines(step);
  
}

void collide_lines(int step) 
{
  stroke(255,0,0);
  
  strokeWeight(2);
  fill(0, 0);
  rect(80 - 2, 80 - 2, width - 2*(80 - 1), height - 2*(80 - 1));
  
  
  
  
  
}
void crosshairs(int step)
{
  for (int i = 0; i < width; i+= step)
  {
    if (i/step%2 == 0)
    {
      stroke(0);
      line(i, height/2, i+step, height/2);
    }
  }
  
  for (int i = 0; i < height; i+= step)
  {
    if (i/step%2 == 0)
    {
      stroke(255);
      line(width/2, i, width/2, i+step);
    }
  }
}