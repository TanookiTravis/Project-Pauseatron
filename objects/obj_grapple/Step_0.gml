y -= 28;
distance_travelled += 28;

if (distance_travelled >= 800)
{
    instance_destroy();
    exit;
}

// Hit detection
if (hit_target == noone)
{
    if (collision_point(x, y, obj_bridge, true, true))
    {
        var hit = instance_place(x, y, obj_bridge);
        if (hit != noone)
        {
            obj_player.grapple_state = "pulling";
            obj_player.grapple_target = hit;
        }
    } else if (collision_point(x, y, obj_block_parent, true, true)) {
		instance_destroy();
	}
}