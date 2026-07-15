if (!instance_exists(obj_player))
{
    exit;
}

var hx = 30;
var hy = display_get_gui_height() - 120;

var line_w   = 7;
var line_h   = 36;
var spacing  = 14;

draw_set_color(c_red);
for (var i = 0; i < global.max_hp; i++)
{
    var xx = hx + (i * spacing);
    
    if (i < global.player_hp)
    {
        draw_rectangle(xx, hy, xx + line_w, hy + line_h, false);
    }
    else
    {
        draw_rectangle(xx, hy, xx + line_w, hy + line_h, true);
    }
}

draw_set_color(c_white);