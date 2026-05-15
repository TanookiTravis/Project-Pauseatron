draw_self();

// Draw aiming line when using right stick
if (global.gamepad_slot != -1)
{
    var slot = global.gamepad_slot;
    var rh = gamepad_axis_value(slot, gp_axisrh);
    var rv = gamepad_axis_value(slot, gp_axisrv);
    
    if (abs(rh) > 0.3 || abs(rv) > 0.3)   // if aiming with stick
    {
        var aim_dir = point_direction(0, 0, rh, rv);
        
        var start_x = x + lengthdir_x(28, aim_dir);  // same offset as bullet spawn
        var start_y = y + lengthdir_y(28, aim_dir);
        var end_x   = start_x + lengthdir_x(200, aim_dir);
        var end_y   = start_y + lengthdir_y(200, aim_dir);
        
        draw_set_color(c_red);
        draw_set_alpha(0.6);
        draw_line_width(start_x, start_y, end_x, end_y, 4);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}