if (!instance_exists(target)) { instance_destroy(); exit; }
x = target.x;
y = target.y - global.prompt_top_margin;