if (!instance_exists(obj_player))
{
	exit;
}

var ax = display_get_gui_width() - 350;
var ay = 150;
var line_w   = 7;
var line_h   = 36;
var spacing  = 14;

draw_set_color(c_white);
for (var i = 0; i < obj_player.max_ammo; i++) {
    if (i < obj_player.ammo) {
        var xx = ax + (i * spacing);
        draw_rectangle(xx, ay, xx + line_w, ay + line_h, false);
    }
}
draw_set_color(c_white);