if (!instance_exists(target)) {
    instance_destroy();
} else {
    x = target.x;
    y = target.y - global.stealth_kill_prompt_margin;
}