// Global Variables
Table table;
int power;
float friction;

boolean game_over;

//http://www.zapsplat.com/music/miniature-snooker-or-pool-ball-drop-on-snooker-table/

void setup()
{
  size(1600, 800);
  frameRate(60);
  table = new Table (0);
  power = 5;
  friction = 0.5;
  game_over = false;
  
}