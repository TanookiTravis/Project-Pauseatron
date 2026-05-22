/// @desc Shows a speech bubble above an instance
/// @param {Id.Instance} target    The instance the bubble appears above
/// @param {String} text           The text to display
/// @param {Real} duration         How long to show (in frames). Default 180 (3 sec)

// usage: show_speech(obj_player, "Oh nice", 120);

function show_speech(target, text, duration = 180)
{
    if (!instance_exists(target)) return;
    
    // Destroy any existing bubble on this target
    with (obj_speech_bubble)
    {
        if (self.target == target) instance_destroy();
    }
    
    var bubble = instance_create_layer(0, 0, "UI", obj_speech_bubble);
    bubble.target = target;
    bubble.text = text;
    bubble.lifetime = duration;
}