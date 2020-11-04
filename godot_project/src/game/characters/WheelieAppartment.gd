extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var is_open : int = get_state_property("is_open")
	if is_open:
		_animated_sprite.play("is_open")
	else:
		_animated_sprite.play("default")
