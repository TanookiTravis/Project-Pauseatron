//var dist = point_distance(x, y, obj_player.x, obj_player.y);
//var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
var dir = point_direction(x, y, obj_player.x, obj_player.y);
var dist = point_distance(x, y, obj_player.x, obj_player.y);
var stealth_kill_distance = 200;

// === STATE MACHINE ===
switch (enemy_state)
{
    case "patrol":
        sprite_index = spr_boy_walk;
        image_speed = 1;
        hspeed = 1;
        event_inherited(); // normal patrol movement
        
        // First time spotting player
        if (dist < aggro_range)
        {
            var facing_player = (obj_player.x > x && image_xscale > 0) || (obj_player.x < x && image_xscale < 0);
            if (facing_player && !collision_line(x, y, obj_player.x, obj_player.y + obj_player.detection_y_offset, obj_env_collision, false, true))
            {
                enemy_state = "investigating";
                alert_timer = 1.8 * 60;   // seconds to confirm
                show_debug_message("Enemy started investigating");
            }
        }
        break;
       
    case "investigating":
	    sprite_index = spr_boy_investigating;
	    image_speed = 0.7;
    
	    var dir_to_player = sign(obj_player.x - x);
	    hspeed = 1.2 * dir_to_player;
	    image_xscale = dir_to_player;        // force facing
    
	    // Show speech only once
	    if (!variable_instance_exists(id, "has_shown_investigate_line") || has_shown_investigate_line == false)
	    {
	        has_shown_investigate_line = true;
	        var line = investigating_lines[irandom(array_length(investigating_lines)-1)];
	        show_speech(id, line, 110);
	    }
    
	    // Still has LOS?
	    if (dist < aggro_range && !collision_line(x, y, obj_player.x, obj_player.y + obj_player.detection_y_offset, obj_env_collision, false, true))
	    {
	        alert_timer--;
	        if (alert_timer <= 0)
	        {
	            enemy_state = "alert";
	            alert_timer = 6 * 60;
	        }
	    }
	    else
	    {
	        // Going back to patrol - clean reset
	        enemy_state = "patrol";
	        hspeed = 0;                    // important: reset hspeed
	    }
	    break;
       
    case "alert":
        sprite_index = spr_boy_spotted;
        hspeed = 0;
        image_speed = 0;
        image_index = 0;
        
        // Face the player
        if (obj_player.x < x) {
            image_xscale = -abs(image_xscale);
        } else {
            image_xscale = abs(image_xscale);
        }
   
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
   
        // Timer countdown
        alert_timer--;
        if (alert_timer <= 0)
        {
            enemy_state = "patrol";
            alert_timer = 0;
			var patrol_line = patrol_lines[irandom(array_length(patrol_lines)-1)];
			show_speech(id, patrol_line, 90);
        }
        break;
}

// === STEALTH KILL CHECK ===
if (dist < stealth_kill_distance)
{
    var behind = false;
    if (image_xscale > 0 && obj_player.x < x) behind = true;
    else if (image_xscale < 0 && obj_player.x > x) behind = true;
   
    if (behind)
    {
        // Create / update prompt
        if (!instance_exists(obj_prompt_stealth) || obj_prompt_stealth.target != id)
        {
            instance_destroy(obj_prompt_stealth);
            
            var new_prompt = instance_create_layer(x, y - global.prompt_top_margin, "UI", obj_prompt_stealth);
            new_prompt.target = id;
            
            show_debug_message("Prompt created for enemy " + string(id));
        }
        
        // Stealth Kill (B button)
        if (global.gamepad_slot != -1 && gamepad_button_check_pressed(global.gamepad_slot, gp_face2))
        {
            audio_play_sound(snd_ankle_breaker, 0, 0);
            instance_destroy(obj_prompt_stealth);
            instance_destroy();
            instance_create_layer(x, y, layer, defeated_object);
        }
    }
}

// Stealth prompt cleanup
var p = instance_find(obj_prompt_stealth, 0);
if (instance_exists(p) && (!instance_exists(p.target) || 
    point_distance(p.target.x, p.target.y, obj_player.x, obj_player.y) > stealth_kill_distance))
{
    instance_destroy(p);
}

// Cooldown
shoot_cooldown = max(0, shoot_cooldown - 1);