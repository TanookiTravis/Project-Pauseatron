if (!instance_exists(target_enemy)) { instance_destroy(); exit; }

x = target_enemy.x;
y = target_enemy.y - 50;

// Press the button (change "E" to whatever key you want)
if (keyboard_check_pressed(ord("E")))
{
    target_enemy.state = "defeated";     // or whatever state you use
    // Optional: play death animation, etc.
    instance_destroy(target_enemy);
    instance_destroy();
}