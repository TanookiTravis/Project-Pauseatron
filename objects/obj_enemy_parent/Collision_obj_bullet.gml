var damage = 1;
var is_headshot = (y > other.y - other.sprite_height/2 + 90);
show_debug_message("-----NEW BULLET-----");
show_debug_message("is_headshot: " + string(y) + " > " + string(other.y - other.sprite_height/2 + 90));

if (is_headshot)
{
    // Instant kill on headshot
	audio_play_sound(snd_ankle_breaker, 0, 0);
	instance_create_layer(x, y, layer, obj_enemy2_dead_headshot);
	instance_destroy(); // destroy enemy
}
else if (enemy_hp > 0)
{
    // Normal body hit
    enemy_hp -= damage;
    
    if (enemy_hp <= 0)
    {
		show_debug_message("Enemy died by body shot");
		audio_play_sound(snd_enemy_dead, 0, 0);
		instance_create_layer(x, y, layer, defeated_object);
		instance_destroy(); // destroy enemy
    }
}
instance_destroy(obj_bullet); // destroy bullet