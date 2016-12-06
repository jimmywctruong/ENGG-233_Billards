class Table
{
  Ball [] b_arr; //the length of this array can be 1 for
  Ball cue_ball; //iteration 3
  Ball [] all_balls;
  Stick st;

  Table (int balls)
  {

    cue_ball = new Ball (rad, 400, 400, color(255, 255, 255));
    b_arr = new Ball [balls]; //
    all_balls = new Ball [balls+1];
    create_balls();

    st = new Stick (200);
  }
  void fade_balls()
  {

    for (int i = 0; i < all_balls.length; i++)
    {
      if (all_balls[i].pocketed == true)
      {
        all_balls[i].change_color();
      }
    }
  }
  void create_balls()
  {
    //Ball (float r, float x, float y, color co)
    color [] co_arr = { 0, 100, color (255, 0, 0), color (0, 255, 0), color (0, 0, 255), color (255, 0, 255)};
    float [] x = {800, 850, 850, 900, 900, 900};
    float [] y = {height/2, height/2 - 30, height/2 + 30, height/2, height/2 - 60, height/2 + 60 };



    for (int i = 0; i < b_arr.length; i++)
    {
      b_arr[i] = new Ball (rad, x[i], y[i], co_arr[i]);
    }

    b_arr[0].x_vel = -20;

    all_balls [0] = cue_ball;
    for (int i = 1; i < all_balls.length; i++)
    {

      all_balls[i] = b_arr[i-1];
    }
  }

  void check_ball_collisions()
  {
    
      //  All balls is used for a double for loop. Checks each ball with all other balls for a collision. 
      for (int i = 0; i < all_balls.length; i++)
      {

        for (int j = 0; j < all_balls.length; j++)
        {
          if (i != j)  //  Prevents a ball from checking for a collision with itself.
          {
            float x1 = all_balls[i].center.x;
            float y1 = all_balls[i].center.y;

            float x2 = all_balls[j].center.x;
            float y2 = all_balls[j].center.y;


            if (distance(all_balls[i].center.x, y1, x2, y2) <= 2*rad) //  If two balls are within collision distance
            {

              all_balls[i].center.x -= all_balls[i].x_vel;
              all_balls[i].center.x -= all_balls[i].y_vel;

               x1 = all_balls[i].center.x;
               y1 = all_balls[i].center.y;

              float vx1 = all_balls[i].x_vel;
              float vy1 = all_balls[i].y_vel;

              float vx2 = all_balls[j].x_vel;
              float vy2 = all_balls[j].y_vel;

              float dvx = vx1 - vx2;
              float dvy = vy1 - vy2;

              float dx = x1 - x2;
              float dy = y1 - y2;

              float k = (dvx*dx + dvy*dy)/(dx*dx+dy*dy);


              all_balls[i].x_vel -= k*dx;  
              all_balls[i].y_vel -= k*dy;

              all_balls[j].x_vel += k*dx;
              all_balls[j].y_vel += k*dy;
              all_balls[i].friction_move();
              all_balls[j].friction_move();


            }
          }
        
      }
    }
  }

  void draw()
  {
    draw_table();
    draw_balls();
    fade_balls();
    draw_stick();
  }
  void draw_stick()
  {
    st.display();
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
    float border = 80; //  Wall border thickness


    draw_rect (border);
    draw_holes ();
  }

  void draw_rect (float border)
  {

    strokeWeight(0);

    fill(139, 69, 19);  //  Brown
    rect(0, 0, width, height);  //  Brown Border rect

    fill(58, 181, 3); //  Light Green
    rect(border*2.0/3.0, border*2.0/3.0, width - (4.0/3.0*border), height - (4.0/3.0*border));  //  Light Green rect

    fill(10, 108, 3); //  Dark Green
    rect(border, border, width - 2*border, height - 2*border); //  Dark Green rect
  }

  void draw_holes ()
  {
    stroke(0, 0);
    fill(0);

    float m = 1.25; //  Multiplier
    float [] x = {hole*m, width - hole*m, hole*m, width - hole*m, width/2, width/2};
    float [] y = {hole*m, hole*m, height - hole*m, height - hole*m, hole*m, height - hole*m};

    //  Draw Holes
    for (int i = 0; i < 6; i++)
    {
      ellipse(x[i], y[i], hole, hole);
    }
  }
}