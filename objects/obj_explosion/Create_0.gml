damage = 5;
radius = 100;          // starting size
max_radius = 150;      // final explosion size
timer = 25;            // how long the visual lasts (in steps)
alpha = 1;             // transparency

audio_play_sound(snd_explosion_grenade, 0, false);

with (obj_enemy_parent)
{
    if (point_distance(x, y, other.x, other.y) < other.max_radius)
    {
        enemy_hp -= other.damage;
		
		// TODO: Damage blocks
		//block_hp -= 2;
        //if (block_hp <= 0) instance_destroy();
    }
}

// Alert all enemies nearby
with (obj_enemy_parent)
{
    if (point_distance(x, y, other.x, other.y) < 2000)
    {
        enemy_state = "investigating";
        alert_timer = 15 * 60;   // 15 seconds at 60 fps
    }
}

// TODO: give this object an explosion sprite with animation
image_speed = 1;