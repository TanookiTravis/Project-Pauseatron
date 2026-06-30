radius += 4;           // how fast it expands
timer--;
alpha = timer / 25;    // fade out as timer runs down

if (timer <= 0)
{
    instance_destroy();
}