extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var battery_inserted : int = local_variables.get("battery_inserted", 0)
	if battery_inserted:
		_animated_sprite.play("battery_inserted")
	else:
		_animated_sprite.play("default")
