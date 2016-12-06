class Ball
{
  float rad;
  Point center;
  Point contact_point;
  color col;
  float colr;
  float colg;
  float colb;

  float x_vel;
  float y_vel;

  //  Top left = 1, top right = 2, bottom left = 3, bottom right = 4
  int quadrant;  //  Used to skip unneccessary calculations

  boolean pocketed;


  boolean is_moving;

  Ball (float r, float x, float y, color co)
  {
    rad = r;
    center = new Point (x, y);
    contact_point = new Point ();
    col = co;

    x_vel = 0;
    y_vel = 0;
    pocketed = false;

    update_quadrant();
  }
  void change_color()
  {
    float r = red(col);
    float g = green(col);
    float b = blue(col);
    if (r > 0 || g > 0 || b > 0)
    {
      r -= 5;
      g -= 5;
      b -= 5;
    }
    col = color(r, g, b);
  }
  void display () 
  {
    fill(col);
    stroke (0);
    strokeWeight(3);
    ellipse ((int) center.x, (int) center.y, rad*2, rad*2);
  }
  void move()
  {
    center.x += x_vel;
    center.y += y_vel;
  }
  void friction_move()
  {
    float speed = sqrt(x_vel*x_vel + y_vel*y_vel);

    if (speed >= friction)
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

    if ((center.x <= x_line) && (center.y <= y_line))
    {
      quadrant = 1; //  Top left
    } else if ((center.x > x_line) && (center.y <= y_line))
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

  void stop(float x, float y)
  {
    center.x = x;
    center.y = y;

    x_vel = 0;
    y_vel = 0;

    pocketed = true;
  }
  void check_pockets()
  {
    float m = 1.25; // Multiplier
    float hm = hole*m; // Hole
    if (quadrant == 1)
    {
      if (distance(center.x, center.y, hm, hm) <= rad)
      {
        stop(hm, hm);
      }
    } else if (quadrant == 2)
    {
      if (distance(center.x, center.y, width - hm, hm) <= rad)
      {
        stop(width - hm, hm);
      }
    } else if (quadrant == 3)
    {
      if (distance(center.x, center.y, hm, height - hm) <= rad)
      {
        stop(hm, height - hm);
      }
    } else if (quadrant == 4)
    {
      if (distance(center.x, center.y, width - hm, height - hm) <= rad)
      {
        stop(width - hm, height - hm);
      }
    } 

    if (quadrant == 1 || quadrant == 2)
    {

      if (distance(center.x, center.y, width/2, hm) <= rad)
      {
        stop(width/2, hm);
      }
    } else if (quadrant == 3 || quadrant == 4)
    {
      if (distance(center.x, center.y, width/2, height - hm) <= rad)
      {
        stop( width/2, height - hm);
      }
    }

    //    Pockets Info
    // void draw_holes (float hole)
    //{
    //  stroke(0, 0);
    //  fill(0);
    //  //  Draw Corner Holes
    //  ellipse(hole*1.25, hole*1.25, hole, hole);
    //  ellipse(width - hole*1.25, hole*1.25, hole, hole);
    //  ellipse(hole*1.25, height - hole*1.25, hole, hole);
    //  ellipse(width - hole*1.25, height - hole*1.25, hole, hole);
    //  //  Draw Middle Holes
    //  ellipse(width/2, hole, hole, hole);

    //  ellipse(width/2, height -     hole, hole, hole);
    //}
  }

  void check_wall_collisions()
  {
    if (pocketed != true)
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


    if ( (center.y - rad <= border) || (center.y + rad >= (height - border)))
    {
      contact_point.x = center.x;  //  Same for horizontal wall collisions

      //  Calculates the previous position of the ball using 
      //  old position = current position - old_velocity
      //  where new_velocity = old_velocity - friction,
      //  or old_velocity = new_velocity + friction.
      xp = center.x - x_vel + friction;  
      yp = center.y - y_vel + friction;

      y_vel *= -1;  //  Elastic Collision, y velocity reverses

      if (center.y - rad <= border)  //  Top Wall Collision
      {
        wall = border;   
        contact_point.y = center.y - rad;
      } else if (center.y + rad >= (height - border))  //  Bottom Wall Collision
      {
        wall = height - border;
        contact_point.y = center.y + rad;
      }

      center.x = xp + (contact_point.x - xp)/(contact_point.y - yp)*(contact_point.y - wall);  //  Corrected x position based on interpolation
      center.y = yp + contact_point.y - wall;  //  Corrected y position

      move();

      wall_hit.play(0);
    }
  }
  void check_vertical_walls()
  {

    int wall;    //  Wall position, y = 80 for the top wall and 
    //  y = height - border for the bottom wall
    float xp, yp; //  Previous x and y value before overshooting the wall.


    if ( (center.x - rad <= border) || (center.x + rad >= (width - border)))
    {
      contact_point.y = center.y;  //  Same for vertical wall collisions

      //  Calculates the previous position of the ball using 
      //  old position = current position - old_velocity
      //  where new_velocity = old_velocity - friction,
      //  or old_velocity = new_velocity + friction.
      xp = center.x - x_vel + friction;  
      yp = center.y - y_vel + friction;

      x_vel *= -1;  //  Elastic Collision, y velocity reverses

      if (center.x - rad <= border)  //  Left Wall Collision
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