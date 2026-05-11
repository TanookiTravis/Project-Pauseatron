var bullet = instance_create_layer(x, y, "Bullets", obj_bullet);
bullet.direction = point_direction(x, y, mouse_x, mouse_y); // or aim direction
bullet.speed = 15;
bullet.bounces = 4;        // customize per bullet type