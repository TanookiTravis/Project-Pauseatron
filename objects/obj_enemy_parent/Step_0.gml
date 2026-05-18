var dist = point_distance(x, y, obj_player.x, obj_player.y);
var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
var dir = point_direction(x, y, obj_player.x, obj_player.y);

var stealth_kill_distance = 200;

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
	    var aim_dir = point_direction(x, y, obj_player.x, obj_player.y);
	    if (random(1) < 0.5) aim_dir += random_range(-20, 20);
    
	    var bullet = instance_create_layer(x, y, "Bullets", obj_enemy_bullet);
    
	    bullet.hspeed = lengthdir_x(25, aim_dir);
	    bullet.vspeed = lengthdir_y(25, aim_dir);
	    bullet.image_angle = aim_dir;
		bullet.image_xscale = 2;
		bullet.image_yscale = 2;
    
	    show_debug_message("Enemy bullet created at " + string(bullet.x) + ", " + string(bullet.y));
    
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
	
	// === STEALTH KILL CHECK ===
	if (point_distance(x, y, obj_player.x, obj_player.y) < stealth_kill_distance)
	{
	    var behind = false;
	    if (image_xscale > 0 && obj_player.x < x) behind = true;
	    else if (image_xscale < 0 && obj_player.x > x) behind = true;
    
	    if (behind)
	    {
			// Only one enemy gets to control the prompt
			var current_prompt = instance_find(obj_prompt_stealth, 0);
			
	        // Only this enemy should have the prompt
	        if (!instance_exists(current_prompt))
	        {
	            var new_prompt = instance_create_layer(x, y-global.stealth_kill_prompt_margin, "UI", obj_prompt_stealth);
	            new_prompt.target = id;
	        }
	        else if (current_prompt.target != id)
	        {
	            // Switch to closer enemy
	            if (point_distance(x, y, obj_player.x, obj_player.y) < 
	                point_distance(current_prompt.target.x, current_prompt.target.y, obj_player.x, obj_player.y))
	            {
	                instance_destroy(current_prompt);
	                var new_prompt = instance_create_layer(x, y-global.stealth_kill_prompt_margin, "UI", obj_prompt_stealth);
	                new_prompt.target = id;
	            }
	        }
        
	        // Execute stealth kill
		    if (global.gamepad_slot != -1
				&& gamepad_button_check_pressed(global.gamepad_slot, gp_face3))
		    {
				audio_play_sound(snd_ankle_breaker, 0, 0);
		        instance_destroy(obj_prompt_stealth);
		        instance_destroy();
				instance_create_layer(x, y, layer, defeated_object);
		    }
	    }
	}
	
	// Cleanup
	var p = instance_find(obj_prompt_stealth, 0);
	if (instance_exists(p) && (!instance_exists(p.target) || point_distance(p.target.x, p.target.y, obj_player.x, obj_player.y) > stealth_kill_distance))
	{
	    instance_destroy(p);
	}
	
}

shoot_cooldown = max(0, shoot_cooldown - 1);