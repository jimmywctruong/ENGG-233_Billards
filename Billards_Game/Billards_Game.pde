import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer wall_hit;
AudioPlayer cue_hit;

// Global Variables
Table table;
int power;
float friction;
int border;  //  Wall border thickness

boolean game_over;


//http://www.zapsplat.com/music/miniature-snooker-or-pool-ball-drop-on-snooker-table/

void setup()
{
  size(1600, 800);
  
  minim = new Minim(this);
  wall_hit = minim.loadFile("wall_hit.mp3");
  cue_hit = minim.loadFile("cue_hit.mp3");
  
  frameRate(60);
  table = new Table (0);
  power = 5;
  border = 80;
  
  
  friction = 0.1;
  game_over = false;
  
}

void stop()
{
  wall_hit.close();
  cue_hit.close();
  minim.stop();
  
  super.stop();
}