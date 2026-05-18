//var dist = point_distance(x, y, obj_player.x, obj_player.y);
//var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
var dir = point_direction(x, y, obj_player.x, obj_player.y);
var stealth_kill_distance = 200;

// === STATE MACHINE ===
switch (enemy_state)
{
    case "patrol":
        sprite_index = spr_boy_walk;
        image_speed = 1;
        event_inherited(); // normal patrol movement
        
        // Check if enemy should be alert
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        if (dist < aggro_range)
        {
            var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
            if (facing_player && !collision_line(x, y, obj_player.x, obj_player.y, obj_env_collision, false, true))
            {
                enemy_state = "alert";
                alert_timer = 6 * 60;   // seconds at 60fps
            }
        }
        break;
        
	    case "alert":
	    sprite_index = spr_boy_spotted;
	    hspeed = 0;
	    image_speed = 0;
	    image_index = 0;
    
	    // Shooting
	    if (shoot_cooldown <= 0)
	    {
	        var aim_dir = point_direction(x, y, obj_player.x, obj_player.y);
	        if (random(1) < 0.5) aim_dir += random_range(-20, 20);
   
	        var bullet = instance_create_layer(x, y, "Bullets", obj_enemy_bullet);
	        bullet.hspeed = lengthdir_x(25, aim_dir);
	        bullet.vspeed = lengthdir_y(25, aim_dir);
	        bullet.image_angle = aim_dir;
	        bullet.image_xscale = 2;
	        bullet.image_yscale = 2;
   
	        shoot_cooldown = shoot_interval;
	    }
    
	    // Timer countdown - always runs while in alert
	    alert_timer--;
	    if (alert_timer <= 0)
	    {
	        enemy_state = "patrol";
	        alert_timer = 0;
	    }
	    break;
}

// Cooldown
shoot_cooldown = max(0, shoot_cooldown - 1);