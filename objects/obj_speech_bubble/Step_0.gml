if (!instance_exists(target) || lifetime <= 0)
{
    instance_destroy();
    exit;
}

x = target.x;
y = target.y - target.sprite_height + 40;   // above head

lifetime--;