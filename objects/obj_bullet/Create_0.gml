hspeed = 0;
vspeed = 0;
distance_travelled = 0;

bounce_factor = 0.92;     // 1.0 = perfect energy, lower = loses speed on bounce
max_bounces = 0;          // How many times it can bounce before being destroyed
bounces = max_bounces;    // Bounces = how many times bullet can hit a wall, declared in obj_player

image_angle = direction;  // Rotate sprite to face movement direction

image_xscale = 2;
image_yscale = 2;