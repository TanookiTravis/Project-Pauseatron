event_inherited();

// Set the position of the default audio listener to the player's position, for positional audio
// with audio emitters (such as in obj_end_gate)
audio_listener_set_position(0, x, y, 0);

// === GAMEPAD FIRING ===
if (global.gamepad_slot != -1)
{
    var slot = global.gamepad_slot;
    
    var right_h = gamepad_axis_value(slot, gp_axisrh);
    var right_v = gamepad_axis_value(slot, gp_axisrv);
    
    var aim_dir;
    
    // Use direction player is aiming
    if (abs(right_h) > 0.3 || abs(right_v) > 0.3)
    {
        aim_dir = point_direction(0, 0, right_h, right_v);
    }
    else
    {
        // No aiming, shoot direction character is facing
        aim_dir = (image_xscale > 0) ? 0 : 180;
    }
        
    if (gamepad_button_check_pressed(slot, gp_shoulderrb))   // R2
    {
        var bullet = instance_create_layer(
            x + lengthdir_x(28, aim_dir), 
            y + lengthdir_y(28, aim_dir), 
            "Bullets", 
            obj_bullet
        );
            
        bullet.direction = aim_dir;
        bullet.speed = 16;
        bullet.bounces = 2;
        bullet.bounce_factor = 0.90;
    }
}