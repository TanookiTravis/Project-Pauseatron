event_inherited();

// Set the position of the default audio listener to the player's position, for positional audio
// with audio emitters (such as in obj_end_gate)
audio_listener_set_position(0, x, y, 0);

// === CROUCHING ===
var left_v = gamepad_axis_value(global.gamepad_slot, gp_axislv);
var crouch_input = (left_v > 0.65);

if (crouch_input)
{
    if (!is_crouching)
    {
        is_crouching = true;
        sprite_index = spr_player_crouch;
        detection_y_offset = 18;     // adjust this (higher = lower detection point)
    }
}
else if (is_crouching)
{
    is_crouching = false;
    sprite_index = spr_player_idle;
    detection_y_offset = 0;
}

// === GAMEPAD FIRING ===
if (global.gamepad_slot != -1)
{
    var slot = global.gamepad_slot;
   
    var right_h = gamepad_axis_value(slot, gp_axisrh);
    var right_v = gamepad_axis_value(slot, gp_axisrv);
    var holding_l2 = gamepad_button_check(slot, gp_shoulderlb);  
   
    var aim_dir;
   
    if (holding_l2 && (abs(right_h) > 0.25 || abs(right_v) > 0.25))
    {
        // Precise aiming only when holding L2
        aim_dir = point_direction(0, 0, right_h, right_v);
    }
    else
    {
        // Normal mode - always shoot facing direction
        aim_dir = (image_xscale > 0) ? 0 : 180;
    }
   
    if (gamepad_button_check_pressed(slot, gp_shoulderrb)) // R2
    {
		var vertical_offset = 64;
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