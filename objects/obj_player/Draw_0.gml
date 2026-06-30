draw_self();

// Draw red aiming lasers for shooting and grenades
if (global.gamepad_slot != -1 && !is_hanging)
{
    var slot = global.gamepad_slot;
    var holding_l2 = gamepad_button_check(slot, gp_shoulderlb);
    var holding_l1 = gamepad_button_check(slot, gp_shoulderl);
	
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
    
	// Shooting
    if (holding_l2)
    {        
		var vertical_offset = 82;
        var start_x = x + lengthdir_x(36, aim_dir);
        var start_y = (y - vertical_offset) + lengthdir_y(28, aim_dir);
		// length of laser sight
        var end_x   = start_x + lengthdir_x(200, aim_dir);
        var end_y   = start_y + lengthdir_y(200, aim_dir);
        
        draw_set_color(c_red);
        draw_set_alpha(0.6);
        draw_line_width(start_x, start_y, end_x, end_y, 3);
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    } else if (holding_l1) 
    {
		// Grenades
		var throw_dir = aim_dir;
	    var throw_spd = 15;
	    var grav = 0.3;
	    var steps = 40;

	    var px = x;
	    var py = y - 20;
	    var vx = lengthdir_x(throw_spd, throw_dir);
	    var vy = lengthdir_y(throw_spd, throw_dir);

	    draw_set_color(c_yellow);
	    for (var i = 0; i < steps; i++)
	    {
	        draw_circle(px, py, 2, false);   // dotted arc

	        var next_x = px + vx;
	        var next_y = py + vy;

	        if (place_meeting(next_x, next_y, obj_env_collision)) break; // stop at ground

	        px = next_x;
	        py = next_y;
	        vy += grav;
	    }
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