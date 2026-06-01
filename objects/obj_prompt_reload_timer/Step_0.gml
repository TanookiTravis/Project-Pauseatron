if (!instance_exists(target)) 
{
    instance_destroy();
    exit;
}

x = target.x;
y = target.y - global.prompt_top_margin;
timer = target.reload_timer;   // sync with player's timer