// obj_bullet - Step Event

var _old_x = x;
var _old_y = y;

// Horizontal Movement + Collision
x += hspeed;
if (place_meeting(x, y, obj_env_collision))
{
    while (place_meeting(x, y, obj_env_collision))
    {
        x -= sign(hspeed);
    }
    hspeed = -hspeed * bounce_factor;
    bounces -= 1;
}

// Vertical Movement + Collision
y += vspeed;
if (place_meeting(x, y, obj_env_collision))
{
    while (place_meeting(x, y, obj_env_collision))
    {
        y -= sign(vspeed);
    }
    vspeed = -vspeed * bounce_factor;
    bounces -= 1;
}

// Destroy when bounces run out
if (bounces <= 0)
{
    instance_destroy();
}

// Rotate sprite to match direction
image_angle = direction;