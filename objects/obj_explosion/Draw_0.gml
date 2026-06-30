draw_set_alpha(alpha);
draw_set_color(c_red);

// Outer ring (main explosion)
draw_circle(x, y, radius, true); // outline
draw_circle(x, y, radius * 0.7, false);

// Inner brighter core
draw_set_color(c_yellow);
draw_circle(x, y, radius * 0.4, false);

draw_set_alpha(1);
draw_set_color(c_white);