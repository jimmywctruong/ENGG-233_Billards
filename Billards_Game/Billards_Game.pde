import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;

// Global Variables
AudioPlayer wall_hit;
AudioPlayer cue_hit;

Table table;
int power;
float friction;
int border;  //  Wall border thickness
float hole;

int start_time;
int end_time;

boolean game_over;
int rad = 20;

//http://www.zapsplat.com/music/miniature-snooker-or-pool-ball-drop-on-snooker-table/

void setup()
{
  size(1600, 800);
  frameRate(60);
  cursor(CROSS);
  
  sound_setup();
  
  set_global_vars();
  start_game();
  
  
  
}
void start_game()
{
  set_time();
  table = new Table (6); //  Table (# of balls)
  
}
void set_global_vars()
{
  
  power = 5;
  border = 80;
  friction = 0.1;
  game_over = false;
  hole = 80;
}
void set_time() 
{
  start_time = millis();
  end_time = millis() + 2*60*1000;
}
void sound_setup()
{
  minim = new Minim(this);
  wall_hit = minim.loadFile("wall_hit.mp3");
  cue_hit = minim.loadFile("cue_hit.mp3");
  
}

void stop()
{
  wall_hit.close();
  cue_hit.close();
  minim.stop();
  
  super.stop();
}