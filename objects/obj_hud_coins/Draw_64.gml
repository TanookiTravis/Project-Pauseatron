if (!instance_exists(obj_player))
{
    exit;
}

// Position in lower left (same area as health and ammo)
var cx = 25;
var cy = display_get_gui_height() - 210;   // adjust this number to move it up/down

draw_set_font(fnt_hud);
draw_set_color(c_white);

// Draw the coin sprite
draw_sprite(spr_hud_coins, 0, cx, cy);

// Draw the text to the right of the sprite
draw_text(cx + 40, cy - 4, "x" + string(obj_player.grenades));

draw_set_color(c_white);