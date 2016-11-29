// Global Variables
Table table;
int power;
float friction;

void setup()
{
  size(1600, 800);
  frameRate(60);
  table = new Table (0);
  power = 5;
  friction = 0.05;
}