global.gamepad_slot = -1;

for (var i = 0; i < 12; i++)          // Check slots 0 to 11
{
    if (gamepad_is_connected(i))
    {
        global.gamepad_slot = i;
        break;                        // Use the first connected gamepad
    }
}