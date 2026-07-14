// Increase the grenades variable of the player by 1
grenades += 1;
global.player_hp += 1;

// Create an instance of obj_coin_collect_effect at the position of the 'other' instance, which is the
// grenade that the player touched.
instance_create_layer(other.x, other.y, "Instances", obj_coin_collect_effect);

// Play the grenade collect sound
audio_play_sound(snd_coin_collect_01, 0, 0);

// Destroy the 'other' instance, which is the grenade.
instance_destroy(other);