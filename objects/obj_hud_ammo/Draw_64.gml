if (!instance_exists(obj_player))
{
    exit;
}

var ax = 30;
var ay = display_get_gui_height() - 70;
var line_w = 7;
var line_h = 36;
var spacing = 14;

draw_set_color(c_white);

for (var i = 0; i < obj_player.max_ammo; i++) 
{
    var xx = ax + (i * spacing);
    
    if (i < obj_player.ammo) 
    {
        // Filled (player has this bullet)
        draw_rectangle(xx, ay, xx + line_w, ay + line_h, false);
    } 
    else 
    {
        // Hollow (empty slot)
        draw_rectangle(xx, ay, xx + line_w, ay + line_h, true);
    }
}

draw_set_color(c_white);