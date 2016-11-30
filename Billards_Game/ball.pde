class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;

  float x_vel;
  float y_vel;

  //  Top left = 1, top right = 2, bottom left = 3, bottom right = 4
  int quadrant;  //  Used to skip unneccessary calculations
  
  boolean ignore_walls;

  boolean is_moving;

  Ball (float r, float x, float y, color co)
  {
    rad = r;
    center = new Point (x, y);
    contact_point = new Point ();
    col = co;

    x_vel = 0;
    y_vel = 0;

    ignore_walls = false;
    update_quadrant();
    
  }

  void display () 
  {
    fill(col);
    stroke (0);
    strokeWeight(3);
    ellipse (center.x, center.y, rad*2, rad*2);
  }

  void move()
  {
    float speed = sqrt(x_vel*x_vel + y_vel*y_vel);

    if (speed > friction)
    {
      is_moving = true;

      center.x += x_vel;
      center.y += y_vel;
      
      //  New velocity = old velocity - old velocity * cos/sin of angle.
      //  x_vel = x_vel - friction * cos(angle) = x_vel - friction * (x_vel / speed)
      x_vel = x_vel*(1-friction/speed);
      y_vel = y_vel*(1-friction/speed);
      
      update_quadrant();
      
    } else 
    {
      is_moving = false;
    }
    
  }
  
  void update_quadrant()
  {
    int x_line = width/2;
    int y_line = height/2;
    
    if((center.x <= x_line) && (center.y <= y_line))
    {
      quadrant = 1; //  Top left
    } else if((center.x > x_line) && (center.y <= y_line))
    {
      quadrant = 2; //  Top right
    } else if ((center.x <= x_line) && (center.y > y_line))
    {
      quadrant = 3; //  Bottom left
    } else if ((center.x > x_line) && (center.y > y_line))
    {
      quadrant = 4; //  Bottom right
    }
  }

  void check_pockets()
  {
    stroke(255);
    rect(border*.75, border*1.25, 2, 2);
    rect(border, border*1.5, 2, 2);
    
    rect(border*1.25, border*.75, 2, 2);
    rect(border*1.5, border, 2, 2);
    
    if (quadrant == 1)
    {
      if ((center.x < border + 1.5*rad) && (center.y < border + 1.5*rad))
      {
        
        ignore_walls = true;
      } else 
      {
        ignore_walls = false;
      }
            //rect(border, border, 2*table.cue_ball.rad, 2*table.cue_ball.rad);
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



      wall_hit.play(0);
    }
  }
  void check_vertical_walls()
  {

    int wall;    //  Wall position, y = 80 for the top wall and 
    //  y = height - border for the bottom wall
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

      if (center.x - rad < border)  //  Left Wall Collision
      {
        wall = border;   
        contact_point.x = center.x - rad;
      } else  //  Right Wall Collision
      {
        wall = width - border;
        contact_point.x = center.x + rad;
      }

      center.y = yp + (contact_point.y - yp)/(contact_point.x - xp)*(contact_point.x - wall);  //  Corrected y position based on interpolation
      center.x = xp + contact_point.x - wall;  //  Corrected x position

      wall_hit.play(0);
    }
  }
}