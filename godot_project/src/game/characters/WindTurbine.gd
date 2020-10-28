extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var has_battery : int = get_state_property("has_battery")
	if has_battery:
		_animated_sprite.play("has_battery")
	else:
		_animated_sprite.play("default")
