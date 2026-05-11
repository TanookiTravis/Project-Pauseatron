// This object handles gamepad input.
// Gamepads are detected in the Async - System event, and added into a list.
// This creates that list, and calls it 'gamepads'.
gamepads = ds_list_create();

// obj_gamepad_manager
global.gamepad_slot = -1;   // -1 means no gamepad found