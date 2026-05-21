block_hp -= 1;

instance_create_layer(x + 0, y + 0, layer, obj_block_brick_destroy);
show_debug_message("Block HP: " + string(block_hp));
	
if (block_hp <= 0)
{
	show_debug_message("Block destroyed");
	instance_destroy();
}