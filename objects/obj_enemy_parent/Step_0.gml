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

// === STEALTH KILL CHECK (runs in BOTH states) ===
var dist = point_distance(x, y, obj_player.x, obj_player.y);
if (dist < stealth_kill_distance)
{
    var behind = false;
    if (image_xscale > 0 && obj_player.x < x) behind = true;
    else if (image_xscale < 0 && obj_player.x > x) behind = true;
   
    if (behind)
    {
        var current_prompt = instance_find(obj_prompt_stealth, 0);
        
        if (!instance_exists(current_prompt))
        {
            var new_prompt = instance_create_layer(x, y-global.stealth_kill_prompt_margin, "UI", obj_prompt_stealth);
            new_prompt.target = id;
        }
        else if (current_prompt.target != id)
        {
            if (dist < point_distance(current_prompt.target.x, current_prompt.target.y, obj_player.x, obj_player.y))
            {
                instance_destroy(current_prompt);
                var new_prompt = instance_create_layer(x, y-global.stealth_kill_prompt_margin, "UI", obj_prompt_stealth);
                new_prompt.target = id;
            }
        }
       
        if (global.gamepad_slot != -1 && gamepad_button_check_pressed(global.gamepad_slot, gp_face3))
        {
            audio_play_sound(snd_ankle_breaker, 0, 0);
            instance_destroy(obj_prompt_stealth);
            instance_destroy();
            instance_create_layer(x, y, layer, defeated_object);
        }
    }
}

// Prompt Cleanup
var p = instance_find(obj_prompt_stealth, 0);
if (instance_exists(p) && (!instance_exists(p.target) || 
    point_distance(p.target.x, p.target.y, obj_player.x, obj_player.y) > stealth_kill_distance))
{
    instance_destroy(p);
}

// Cooldown
shoot_cooldown = max(0, shoot_cooldown - 1);