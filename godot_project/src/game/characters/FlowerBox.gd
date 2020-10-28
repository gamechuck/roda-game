extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var has_rose_seeds : int = get_state_property("has_rose_seeds")
	if has_rose_seeds:
		_animated_sprite.play("has_rose_seeds")
	else:
		_animated_sprite.play("default")
