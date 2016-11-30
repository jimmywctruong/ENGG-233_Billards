class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;

  float x_vel;
  float y_vel;

  boolean ignore_walls;
  boolean pocketed;

  Ball (float r, float x, float y, color co)
  {
    rad = r;
    center = new Point (x, y);
    contact_point = new Point ();
    col = co;

    x_vel = 0;
    y_vel = 0;

    ignore_walls = false;
  }

  void move()
  {
    float speed = sqrt(x_vel*x_vel + y_vel*y_vel);


    if (speed > friction)
    {
      center.x += x_vel;
      x_vel = x_vel*(1-friction/speed);
      center.y += y_vel;
      y_vel = y_vel*(1-friction/speed);
    }
  }



  boolean is_moving()
  {
    if ((x_vel !=0) || (y_vel != 0))
    {
      return true;
    }
    return false;
  }

  void display () 
  {
    fill(col);
    stroke (0);
    strokeWeight(3);
    ellipse (center.x, center.y, rad*2, rad*2);
  }
  void check_pockets()
  {
    
    int x_line = height/2;
    int y_line = width/2;
    
    
    
    boolean top_left = false;
    boolean top_right = false;
    boolean bottom_left = false;
    boolean bottom_right = false;

    
    if (distance(center.x, center.y, width/2, 45) < 65.0)
    {
      print(distance(center.x, center.y, width/2, 45));
      game_over = true;
    }
    if (distance(center.x, center.y, width/2, height - 45) < 65.0)
    {
      game_over = true;
    }
    
    if (center.x < x_line && center.y < y_line)
    {
      top_left = (center.x < border + 2*rad) && (center.y < border + 2*rad);
      //println("Q1");
    }

    if (center.x > x_line && center.y < y_line)
    {
      top_right = (center.x > width - (border + 2*rad) && (center.y < border + 2*rad));
      //println("Q2");
    }

    
      bottom_left = (center.x < border + 2*rad) && (center.y > height - (border + 4*rad));
      
    
    
      bottom_right = (center.x > width - (border + 2*rad)) && (center.y > height - (border + 2*rad));
      
    
    
    

    if (top_left || top_right || bottom_left || bottom_right)
    {
      ignore_walls = true;
      print("AAA");
      
      if (top_left)
      {
        println("1");
        if (distance(center.x, center.y, 45, 45) < 100)
        {
          game_over = true;
        }
      }
      if (top_right)
      {
        println("2");
        if (distance(center.x, center.y, width - 45, 45) < 100)
        {
          game_over = true;
        }
      }

      if (bottom_left)
      {
        println("3");
        if (distance(center.x, center.y, 45, height - 45) < 200)
        {
          
          game_over = true;
        }
      }
      if (bottom_right)
      {
        println("4");
        if (distance(center.x, center.y, width - 45, height - 45) < 100)
        {
          game_over = true;
        }
      }
      //ellipse(hole,         hole,          hole, hole);
      //ellipse(width - hole, hole,          hole, hole);
      //ellipse(hole,         height - hole, hole, hole);
      //ellipse(width - hole, height - hole, hole, hole);
    } else 
    {
      ignore_walls = false;
    }
    
  }
  
  void check_wall_collisions()
  {
    if (ignore_walls == false)
    {
      check_horizontal_walls();
      check_vertical_walls();
    }
  }
  void check_horizontal_walls()
  {
    //  More Precise Wall Collision Code
    //    - When a ball collides with a wall, it might have gone past the wall
    //      before a collision is detected. A line can be drawn from the ball's
    //      previous position to its current position that is past the wall.
    //      This code readjusts the ball's position to increase accuracy at high speeds
    //      using trigonometry and interpolation.
    //

    int wall = 0;    //  Wall position, y = 80 for the top wall and 
    //  y = height - 80 for the bottom wall
    float xp, yp; //  Previous x and y value before overshooting the wall.


    if ( (center.y - rad < border) || (center.y + rad > (height - border)))
    {
      contact_point.x = center.x;  //  Same for horizontal wall collisions

      //  Calculates the previous position of the ball using 
      //  old position = current position - old_velocity
      //  where new_velocity = old_velocity - friction,
      //  or old_velocity = new_velocity + friction.
      xp = center.x - x_vel + friction;  
      yp = center.y - y_vel + friction;

      y_vel *= -1;  //  Elastic Collision, y velocity reverses

      if (center.y - rad < border)  //  Top Wall Collision
      {
        wall = border;   
        contact_point.y = center.y - rad;
      } else if (center.y + rad > (height - border))  //  Bottom Wall Collision
      {
        wall = height - border;
        contact_point.y = center.y + rad;
      }

      center.x = xp + (contact_point.x - xp)/(contact_point.y - yp)*(contact_point.y - wall);  //  Corrected x position based on interpolation
      center.y = yp + contact_point.y - wall;  //  Corrected y position
      println(table.cue_ball.x_vel, table.cue_ball.y_vel);


      wall_hit.play(0);
    }
  }
  void check_vertical_walls()
  {
    //  More Precise Wall Collision Code
    //    - When a ball collides with a wall, it might have gone past the wall
    //      before a collision is detected. A line can be drawn from the ball's
    //      previous position to its current position that is past the wall.
    //      This code readjusts the ball's position to increase accuracy at high speeds
    //      using trigonometry and interpolation.
    //
    int border;  //  Wall border thickness
    int wall = 0;    //  Wall position, y = 80 for the top wall and 
    //  y = height - 80 for the bottom wall
    float xp, yp; //  Previous x and y value before overshooting the wall.

    border = 80;
    if ( (center.x - rad < border) || (center.x + rad > (width - border)))
    {
      contact_point.y = center.y;  //  Same for vertical wall collisions

      //  Calculates the previous position of the ball using 
      //  old position = current position - old_velocity
      //  where new_velocity = old_velocity - friction,
      //  or old_velocity = new_velocity + friction.
      xp = center.x - x_vel + friction;  
      yp = center.y - y_vel + friction;

      x_vel *= -1;  //  Elastic Collision, y velocity reverses

      if (center.x - rad < border)  //  ___ Wall Collision
      {
        wall = border;   
        contact_point.x = center.x - rad;
      } else if (center.x + rad > (width - border))  //  ____ Wall Collision
      {
        wall = width - border;
        contact_point.x = center.x + rad;
      }

      center.y = yp + (contact_point.y - yp)/(contact_point.x - xp)*(contact_point.x - wall);  //  Corrected y position based on interpolation
      center.x = xp + contact_point.x - wall;  //  Corrected x position
      println(table.cue_ball.x_vel, table.cue_ball.y_vel);
    }
  }
}