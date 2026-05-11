// === Bullet Step Event ===

var _old_x = x;
var _old_y = y;

// Move horizontally and vertically separately for better collision handling
x += hspeed;
y += vspeed;

// === Horizontal Collision ===
if (place_meeting(x, y, obj_wall)) {
    x = _old_x;                    // Move back to safe position
    hspeed = -hspeed * bounce_factor;   // Bounce with optional energy loss
}

// === Vertical Collision ===
if (place_meeting(x, y, obj_wall)) {
    y = _old_y;                    // Move back
    vspeed = -vspeed * bounce_factor;
}

// Optional: Limit number of bounces
if (bounces <= 0) {
    instance_destroy();
}