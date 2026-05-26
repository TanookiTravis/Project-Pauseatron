var damage = 1;
var is_headshot = (y > other.y - other.sprite_height/2 + 90);

if (is_headshot)
{
    // Instant kill on headshot
	audio_play_sound(snd_ankle_breaker, 0, 0);
	instance_create_layer(x, y, layer, obj_enemy2_dead_headshot);
	instance_destroy();
	//var headshot_line = headshot_lines[irandom(array_length(headshot_lines)-1)];
	//show_speech(obj_player, headshot_line, 60);
}
else if (enemy_hp > 0)
{
    // Normal body hit
    enemy_hp -= damage;
    
    if (enemy_hp <= 0)
    {
		audio_play_sound(snd_enemy_dead, 0, 0);
		instance_create_layer(x, y, layer, defeated_object);
		instance_destroy();
    } else {
		enemy_state = "alert";
        alert_timer = 6 * 60;   // seconds at 60fps
	}
}
instance_destroy(obj_bullet);