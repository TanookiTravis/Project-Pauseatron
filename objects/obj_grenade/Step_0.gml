x += vx;
y += vy;
vy += grav;
image_angle += 8;    // spin effect

// Bounce on ground
if (place_meeting(x, y, obj_env_collision))
{
    y -= vy;
    vy = -vy * 0.5;
    vx *= 0.7;
}

fuse--;
if (fuse <= 0)
{
    instance_create_layer(x, y, layer, obj_explosion);
    instance_destroy();
}