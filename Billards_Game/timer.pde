void timer()
{
  text((end_time - millis())/1000, 100, 100);
  
  if (end_time - millis() <= 0)
  {
    start_game();
  }
}