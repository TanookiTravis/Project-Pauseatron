if (text == "") exit;

draw_set_font(fnt_speech_bubble);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Measure text
var str_w = string_width(text) + padding * 2;
var str_h = string_height(text) + padding * 2;

// Draw rounded rectangle background
draw_set_color(c_black);
draw_set_alpha(0.75);
draw_roundrect_ext(x - str_w/2, y - str_h/2, x + str_w/2, y + str_h/2, 12, 12, false);
draw_set_alpha(1);

// Draw white text
draw_set_color(c_white);
draw_text(x, y, text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);