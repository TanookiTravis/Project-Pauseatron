draw_self();

// Draw red aiming laser anytime L2 is held
if (global.gamepad_slot != -1 && !is_hanging)
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
        
		var vertical_offset = 64;
        var start_x = x + lengthdir_x(28, aim_dir);
        var start_y = (y - vertical_offset) + lengthdir_y(28, aim_dir);
        var end_x   = start_x + lengthdir_x(200, aim_dir);
        var end_y   = start_y + lengthdir_y(200, aim_dir);
        
        draw_set_color(c_red);
        draw_set_alpha(0.7);
        draw_line_width(start_x, start_y, end_x, end_y, 3);
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// === GRAPPLE SHRINKING ROPE ===
var rope_start_x = x;
var rope_start_y = y - 20;
if (grapple_state == "pulling" && grapple_target != noone)
{
    var attach_x = grapple_target.x;
    var attach_y = grapple_target.bbox_top;
    
    var visual_start_y = lerp(rope_start_y, attach_y, 0.4); // higher = faster shrinking rope
    
    draw_set_color(c_ltgray);
    draw_set_alpha(0.8);
    draw_line_width(rope_start_x, visual_start_y, attach_x, attach_y, 2);
    draw_set_alpha(1);
} else if (grapple_state == "shooting")
{    
    if (instance_exists(obj_grapple))
    {
        draw_set_color(c_ltgray);
        draw_set_alpha(0.8);
        draw_line_width(rope_start_x, rope_start_y, obj_grapple.x, obj_grapple.y, 2);
        draw_set_alpha(1);
    }
}