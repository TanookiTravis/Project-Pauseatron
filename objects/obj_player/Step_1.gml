// Inherit the parent event
event_inherited();

// Checks for a jump input
if (jump_input)
{
	// Preforms a player jump
	player_jump();	
}

if (global.gamepad_slot != -1)
{
    var holding_l2 = gamepad_button_check(global.gamepad_slot, gp_shoulderlb);
    
    if (!holding_l2)
    {
		// Checks for a left input
		if (left_input)
		{
			// Preforms a player left movement
			player_left();	
		}

		// Checks for a right input
		if (right_input)
		{
			// Preforms a player right movement
			player_right();	
		}
	}
}