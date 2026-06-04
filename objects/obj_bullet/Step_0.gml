var _old_x = x;
var _old_y = y;
distance_travelled += speed;   // or sqrt(hspeed*hspeed + vspeed*vspeed)

// Horizontal bounce (only bounce off real walls, not destructible blocks)
x += hspeed;
if (place_meeting(x, y, obj_env_collision) && !place_meeting(x, y, obj_block_parent))
{
    while (place_meeting(x, y, obj_env_collision)) x -= sign(hspeed);
    hspeed = -hspeed * bounce_factor;
    bounces--;
}

// Vertical bounce
y += vspeed;
if (place_meeting(x, y, obj_env_collision) && !place_meeting(x, y, obj_block_parent))
{
    while (place_meeting(x, y, obj_env_collision)) y -= sign(vspeed);
    vspeed = -vspeed * bounce_factor;
    bounces--;
}

// Destroy on limits
distance_travelled += speed;   // or point_distance(_old_x, _old_y, x, y)

if (distance_travelled > 1300 || bounces <= max_bounces)
{
    instance_destroy();
}

// Rotate sprite to match direction
image_angle = point_direction(0, 0, hspeed, vspeed);