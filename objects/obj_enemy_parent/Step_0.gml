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
	    if (random(1) < 0.5) aim_dir += random_range(-20, 20);
    
	    var bullet = instance_create_layer(x, y, "Instances", obj_enemy_bullet);  // ← changed layer
    
	    bullet.hspeed = lengthdir_x(25, aim_dir);
	    bullet.vspeed = lengthdir_y(25, aim_dir);
	    bullet.image_angle = aim_dir;
		bullet.image_xscale = 2;
		bullet.image_yscale = 2;
    
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

// Stealth kill check
var behind = false;
if (image_xscale > 0 && obj_player.x < x - 5) behind = true;        // enemy facing right, player on left
else if (image_xscale < 0 && obj_player.x > x + 5) behind = true;   // enemy facing left, player on right

var can_stealth = (behind 
    && point_distance(x, y, obj_player.x, obj_player.y) < 20
    && !instance_exists(obj_stealth_prompt));

if (can_stealth)
{
    // Create prompt above head
    if (!instance_exists(obj_stealth_prompt))
    {
        var prompt = instance_create_layer(x, y-50, "UI", obj_stealth_prompt);
        prompt.target_enemy = id;
    }
}
