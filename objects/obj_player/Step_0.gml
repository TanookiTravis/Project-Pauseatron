event_inherited();

// Set the position of the default audio listener to the player's position, for positional audio
// with audio emitters (such as in obj_end_gate)
audio_listener_set_position(0, x, y, 0);

// === CROUCH TOGGLE ===
var left_v = gamepad_axis_value(global.gamepad_slot, gp_axislv);
var crouch_input = (left_v > 0.65);

if (crouch_input)
{
    if (!is_crouching)
    {
        is_crouching = true;
        sprite_index = spr_player_crouch;
        detection_y_offset = 18;
    }
}
else if (is_crouching)
{
    is_crouching = false;
    sprite_index = spr_player_idle;
    detection_y_offset = 0;
}

// === GAMEPAD FIRING + RELOAD ===
if (global.gamepad_slot != -1 && !is_hanging)
{
    var slot = global.gamepad_slot;
    var right_h = gamepad_axis_value(slot, gp_axisrh);
    var right_v = gamepad_axis_value(slot, gp_axisrv);
    var holding_l2 = gamepad_button_check(slot, gp_shoulderlb);
 
    var aim_dir = (image_xscale > 0) ? 0 : 180;
 
    if (holding_l2 && (abs(right_h) > 0.25 || abs(right_v) > 0.25))
    {
        aim_dir = point_direction(0, 0, right_h, right_v);
    }
 
    // Determine vertical offset based on stance
    var vertical_offset = is_crouching ? 40 : 80;   // crouched = lower spawn point
    
    // Shooting
    if (!is_reloading && ammo > 0 && gamepad_button_check_pressed(slot, gp_shoulderrb))
    {
        var bullet = instance_create_layer(
            x + lengthdir_x(28, aim_dir),
            (y - vertical_offset) + lengthdir_y(28, aim_dir),
            "Bullets",
            obj_bullet
        );
         
        bullet.direction = aim_dir;
        bullet.speed = 25;
        bullet.bounces = 1;
        bullet.bounce_factor = 0.90;
       
        ammo--;
    }
   
        // === RELOAD (only if no stealth prompt exists) ===
	    if (!is_reloading && ammo < max_ammo && gamepad_button_check_pressed(slot, gp_face3))
	    {
	        // Only reload if there is NO stealth prompt active
	        if (!instance_exists(obj_prompt_stealth))
	        {
	            is_reloading = true;
	            reload_timer = reload_time;
	            show_debug_message("Reloading...");
	        }
	        // If a stealth prompt exists, do NOTHING here — let the enemy handle the button press
	    }
   
    // Reload timer
    if (is_reloading)
    {
        reload_timer--;
        if (reload_timer <= 0)
        {
            ammo = max_ammo;
            is_reloading = false;
            show_debug_message("Reload complete");
        }
    }
}

// === RELOAD PROMPT & TIMER ===
if (is_reloading)
{
    // Show reload timer while reloading
    if (!instance_exists(reload_prompt) || reload_prompt.object_index != obj_prompt_reload_timer)
    {
        if (instance_exists(reload_prompt)) instance_destroy(reload_prompt);
        
        reload_prompt = instance_create_layer(x, y-170, "UI", obj_prompt_reload_timer);
        reload_prompt.target = id;
    }
}
else if (ammo <= 0 && !is_reloading)
{
    // Show Y prompt when out of ammo
    if (!instance_exists(reload_prompt) || reload_prompt.object_index != obj_prompt_reload)
    {
        if (instance_exists(reload_prompt)) instance_destroy(reload_prompt);
        
        reload_prompt = instance_create_layer(x, y-50, "UI", obj_prompt_reload);
        reload_prompt.target = id;
    }
}
else
{
    // Clean up when not needed
    if (instance_exists(reload_prompt))
    {
        instance_destroy(reload_prompt);
        reload_prompt = noone;
    }
}

// === Calculate Aim Offset for Camera ===
aim_offset_x = 0;
aim_offset_y = 0;

if (global.gamepad_slot != -1)
{
    var slot = global.gamepad_slot;
    var holding_l2 = gamepad_button_check(slot, gp_shoulderlb);
    var rh = gamepad_axis_value(slot, gp_axisrh);
    var rv = gamepad_axis_value(slot, gp_axisrv);
    
    if (holding_l2 && (abs(rh) > 0.25 || abs(rv) > 0.25))
    {
        var aim_dir = point_direction(0, 0, rh, rv);
        aim_offset_x = lengthdir_x(300, aim_dir);
        aim_offset_y = lengthdir_y(160, aim_dir);   // less vertical movement
    }
}

// === LEDGE GRAB ===
if (!is_hanging && vel_y != 0) // only while in the air
{
    var dir = sign(vel_x);
    if (dir == 0) dir = image_xscale;
    
    // Check for side contact with a potential ledge
    if (place_meeting(x + dir * 16, y, obj_env_collision))
    {
        // Head must have space above the ledge
        if (!place_meeting(x, y - 32, obj_env_collision))
        {
            // Must be empty space below the ledge
            var ground_below = collision_line(x-4, y + 20, x+4, y + 320, obj_env_collision, true, true);
            
            if (ground_below == noone) // completely clear below
            {
                is_hanging = true;
                sprite_index = spr_player_hang;
                image_speed = 0;
                image_index = 0;
                
                hang_x = x;
                hang_y = y - 6;
                
                vel_x = 0;
                vel_y = 0;
            }
        }
    }
}

// === HANGING STATE ===
if (is_hanging)
{
    x = hang_x;
    y = hang_y;
    vel_x = 0;
    vel_y = 0;
    
    // Drop down
    if (left_v > 0.6)
    {
        is_hanging = false;
        vel_y = 5;
    }
    
    // Climb up
    if (left_v < -0.6)
    {
        is_hanging = false;
        sprite_index = spr_player_walk;
        image_speed = 1;
        
        var target_x = x + 40 * image_xscale;
        var target_y = y - sprite_height + 60;
        
        if (!place_meeting(target_x, target_y, obj_env_collision))
        {
            x = target_x;
            y = target_y;
            vel_y = -7;
        }
        else
        {
            // blocked above → drop instead
            vel_y = 6;
        }
    }
}

// === GRAPPLE HOOK INPUT ===
if (global.gamepad_slot != -1 && gamepad_button_check_pressed(global.gamepad_slot, gp_face4))
{
    if (grapple_state == "idle" && !instance_exists(obj_grapple))
    {
        grapple_state = "shooting";
        var g = instance_create_layer(x, y-20, "Bullets", obj_grapple);
        g.start_x = x;
        g.start_y = y-20;
		alarm[1] = 120;
    }
}