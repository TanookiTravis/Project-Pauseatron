event_inherited();

// This is the amount of damage the enemy does to the player.
damage = 1;

// This sets the movement speed for the enemies.
move_speed = 2;
enemy_hp = 5;
enemy_state = "patrol"; // "patrol" or "alert" or "investigating"
alert_timer = 0;
shoot_cooldown = 0;
shoot_interval = 45; // lower = faster shooting

// This applies either move_speed or negative move_speed to the enemy's X velocity. This way the enemy will
// either move left or right (at random).
vel_x = choose(-move_speed, move_speed);

// This sets the friction to 0 so the enemy never comes to a stop.
friction_power = 0;

// handle player detection and shooting
shoot_cooldown = 0;
shoot_interval = 40;     // ~every x steps (~0.75s at 60fps)
aggro_range = 900;
accuracy = 0.6;          // 50% accuracy

patrol_lines = [
	"It was nothing.",
	"Just a mouse?",
	"Meh, whatever.",
	"Nothing I guess.",
	"Must be the wind."
];
investigating_lines = [
	"What was that?",
	"Huh?",
	"Who's there?",
	"Did you hear that?",
	"Hmm...",
	"I swear I saw something..."
];
headshot_lines = [
	"Oh yeahhh.",
	"Got him.",
	"I'm your huckleberry.",
	"Hasta la vista.",
	"Vaya con Dios",
	"See ya."
];