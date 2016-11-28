class Table
{
  Ball [] b_arr; //the length of this array can be 1 for
  Ball cue_ball; //iteration 3
  Stick st;
  //More code
  
  Table (int balls)
  {
    
    cue_ball = new Ball (30, 400, 400, 255);
    b_arr = new Ball [balls];
    Stick st = new Stick ();
  }
  
  void draw()
  {
    draw_table();
    draw_balls();
    
  }
  
  void draw_table() 
  {
    float border = 60;
    float hole = 60;

    draw_rect (border, hole);
    draw_taper (hole);
    draw_holes (hole);
    
  }
  
  void draw_balls()
  {
    cue_ball.display();
    for (int i = 0; i < b_arr.length; i++)
    {
      b_arr[i].display();
    }
    
  }
  
  void draw_rect (float border, float hole)
  {
    fill(10, 108, 3);
    strokeWeight(border);
    
    stroke(139, 69, 19);  //  Brown
    rect(border/2, border/2, width - border, height - border);  //  Outer Border
    stroke(58, 181, 3);
    strokeWeight(border/2);
    rect(border, border, width - (border*2), height - (border*2));  //  Green Inner Edge
    
    strokeWeight(0);
    
  }
  void test ()
  {
    fill(255);
    rect(0,0, 10, 10);
    fill(255, 0, 0);
    rect(0,0,5,5);
    fill(10, 108, 3);
  }
  void draw_taper (float hole)
  {
    stroke(0,0);
    
    pushMatrix();
    translate(hole, hole);
    rotate(-PI/4);
    rect(-hole/2, 0, hole, hole);
    popMatrix();
    
    pushMatrix();
    translate(width - hole, hole);
    rotate(PI/4);
    rect(-hole/2, 0, hole, hole);
    popMatrix();
    
    pushMatrix();
    translate(hole,height - hole);
    rotate(-3*PI/4);
    rect(-hole/2, 0, hole, hole);
    popMatrix();
    
    pushMatrix();
    translate(width - hole,height - hole);
    rotate(3*PI/4);
    rect(-hole/2, 0, hole, hole);
    popMatrix();
    
    
    quad(width/2 - hole/2, .75*hole , width/2 + hole/2, .75*hole , width/2+.75*hole, 1.25*hole, width/2 - .75*hole, 1.25*hole);
    
    quad(width/2+.75*hole, height - 1.25*hole, width/2 - .75*hole, height - 1.25*hole, width/2 - hole/2, height - .75*hole , width/2 + hole/2, height - .75*hole );
  }
  void draw_holes (float hole)
  {
    stroke(0, 0);
    fill(0);
    //  Draw Corner Holes
    ellipse(hole,         hole,          hole, hole);
    ellipse(width - hole, hole,          hole, hole);
    ellipse(hole,         height - hole, hole, hole);
    ellipse(width - hole, height - hole, hole, hole);
    //  Draw Middle Holes
    ellipse(width/2,      .75*hole,          hole, hole);
    ellipse(width/2,      height - .75*hole, hole, hole);
  }
}