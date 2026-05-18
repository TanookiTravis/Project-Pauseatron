damage = 1;

// This checks if the player is invincible, by checking if no_hurt_frames is greater than 0.
if (no_hurt_frames > 0)
{
	// In that case we exit the event so the player is not hurt by the enemy.
	exit;
}

if (global.player_hp > 0)
{
	//hp -= 1;
	global.player_hp -= damage;
	
	// This gives 2 seconds of invincibility to the player.
	no_hurt_frames += 120;

	//// This resets the X and Y velocities of the player so it stops all movement.
	//vel_x = 0;
	//vel_y = 0;

	// This sets a knockback state for 20 frames (using the Alarm below) so user input is
	// disabled for that period, meaning the player doesn't immediately fall into the hurt zone
	// again.
	in_knockback = true;

	alarm[0] = 20;

	// Play the 'life lost' sound effect
	audio_play_sound(snd_life_lost_01, 0, 0);
}