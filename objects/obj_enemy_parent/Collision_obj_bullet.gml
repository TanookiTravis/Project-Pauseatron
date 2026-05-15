damage = 1;

show_debug_message("Enemy HP: " + string(enemy_hp));

if (enemy_hp > 0)
{
	instance_destroy(obj_bullet); // destroy bullet
	
	//hp -= 1;
	enemy_hp -= damage;
	show_debug_message("Enemy HP B: " + string(enemy_hp));

	//alarm[0] = 20;

	if (enemy_hp <= 0) {
		//// Play the 'life lost' sound effect
		//audio_play_sound(snd_life_lost_01, 0, 0);
	
		instance_create_layer(x, y, layer, defeated_object);

		instance_destroy();
	}
}