class Table
{
  Ball [] b_arr; //the length of this array can be 1 for
  Ball cue_ball; //iteration 3
  Stick st;
  
  Table (int balls)
  {
    
    cue_ball = new Ball (20, 400, 400, 255);
    b_arr = new Ball [balls];
    Stick st = new Stick ();
  }
  
  void draw()
  {
    draw_table();
    draw_balls();
    
  }
  void draw_balls()
  {
    cue_ball.display();
    for (int i = 0; i < b_arr.length; i++)
    {
      b_arr[i].display();
    }
    
  }
  
  void draw_table() 
  {
    float border = 60;
    float hole = 60;

    draw_rect (border);
    draw_taper (hole);
    draw_holes (hole);
    
  }
    
  void draw_rect (float border)
  {
    
    strokeWeight(0);
    
    fill(139, 69, 19);  //  Brown
    rect(0, 0, width, height);  //  Brown Border rect
    
    fill(58, 181, 3); //  Light Green
    rect(border, border, width - (border*2), height - (border*2));  //  Light Green rect
    
    fill(10, 108, 3); //  Dark Green
    rect(border*4.0/3.0, border*4.0/3.0, width - 8.0/3.0*border, height - 8.0/3.0*border); //  Dark Green rect
    
  }
  
  void draw_taper (float hole)
  {
    stroke(0,0);
    
    pushMatrix();
    translate(hole, hole);
    rotate(-PI/4);
    rect(-hole/2, hole/2, hole, hole/2);
    popMatrix();
    
    pushMatrix();
    translate(width - hole, hole);
    rotate(PI/4);
    rect(-hole/2, hole/2, hole, hole/2);
    popMatrix();
    
    pushMatrix();
    translate(hole,height - hole);
    rotate(-3*PI/4);
    rect(-hole/2, hole/2, hole, hole/2);
    popMatrix();
    
    pushMatrix();
    translate(width - hole,height - hole);
    rotate(3*PI/4);
    rect(-hole/2, hole/2, hole, hole/2);
    popMatrix();
    
    
    quad(width/2 - hole/2, hole , width/2 + hole/2, hole , width/2+.75*hole, 1.5*hole, width/2 - .75*hole, 1.5*hole);
    
    quad(width/2+.75*hole, height - 1.5*hole, width/2 - .75*hole, height - 1.5*hole, width/2 - hole/2, height - hole , width/2 + hole/2, height - hole );
  }
  void draw_holes (float hole)
  {
    stroke(0, 0);
    fill(0);
    //  Draw Corner Holes
    ellipse(hole*1.25,         hole*1.25,          hole, hole);
    ellipse(width - hole*1.25, hole*1.25,          hole, hole);
    ellipse(hole*1.25,         height - hole*1.25, hole, hole);
    ellipse(width - hole*1.25, height - hole*1.25, hole, hole);
    //  Draw Middle Holes
    ellipse(width/2,          hole,          hole, hole);
    
    ellipse(width/2,      height -     hole, hole, hole);
  }
}