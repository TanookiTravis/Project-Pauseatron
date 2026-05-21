block_hp -= 1;

instance_create_layer(x + 0, y + 0, layer, obj_block_brick_destroy);
	
if (block_hp <= 0)
{
	instance_destroy();
}