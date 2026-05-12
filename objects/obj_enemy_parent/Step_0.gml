var dist = point_distance(x, y, obj_player.x, obj_player.y);
var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
var dir = point_direction(x, y, obj_player.x, obj_player.y);

// Aggro and Line of Sight check
if (dist < aggro_range
	&& facing_player
	&& !collision_line(x, y, obj_player.x, obj_player.y, obj_env_collision, false, true))
{
    //hspeed = 0;                    // stop walking
    //image_speed = 0;
    //image_index = 0;               // freeze on first frame
	sprite_index = spr_boy_spotted;
    
    // Shooting
    if (shoot_cooldown <= 0)
	{
	    show_debug_message("Enemy shooting!");
    
	    var aim_dir = point_direction(x, y, obj_player.x, obj_player.y);
	    if (random(1) < 0.5) aim_dir += random_range(-30, 30);
    
	    var bullet = instance_create_layer(x, y, "Instances", obj_bullet);  // ← changed layer
    
	    bullet.hspeed = lengthdir_x(10, aim_dir);
	    bullet.vspeed = lengthdir_y(10, aim_dir);
	    bullet.image_angle = aim_dir;
	    bullet.distance_travelled = 0;   // reset just in case
    
	    show_debug_message("Bullet created at " + string(bullet.x) + ", " + string(bullet.y));
    
	    shoot_cooldown = shoot_interval;
	}
}
else
{
    // Normal walking behavior (your existing movement code)
	sprite_index = spr_boy_walk;
    image_speed = 1;
    // Inherit the parent event
	event_inherited();
}

shoot_cooldown = max(0, shoot_cooldown - 1);