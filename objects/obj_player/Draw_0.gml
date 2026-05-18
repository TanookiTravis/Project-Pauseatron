draw_self();

// Draw red aiming laser anytime L2 is held
if (global.gamepad_slot != -1)
{
    var slot = global.gamepad_slot;
    var holding_l2 = gamepad_button_check(slot, gp_shoulderlb);
    
    if (holding_l2)
    {
        var rh = gamepad_axis_value(slot, gp_axisrh);
        var rv = gamepad_axis_value(slot, gp_axisrv);
        
        var aim_dir;
        
        // Use right stick if moving it, otherwise use facing direction
        if (abs(rh) > 0.25 || abs(rv) > 0.25)
        {
            aim_dir = point_direction(0, 0, rh, rv);
        }
        else
        {
            aim_dir = (image_xscale > 0) ? 0 : 180;
        }
        
        var start_x = x + lengthdir_x(28, aim_dir);
        var start_y = y + lengthdir_y(28, aim_dir);
        var end_x   = start_x + lengthdir_x(200, aim_dir);
        var end_y   = start_y + lengthdir_y(200, aim_dir);
        
        draw_set_color(c_red);
        draw_set_alpha(0.7);
        draw_line_width(start_x, start_y, end_x, end_y, 3);
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}