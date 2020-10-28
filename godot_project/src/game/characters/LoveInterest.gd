extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var wearing_color : int = get_state_property("wearing_color")
	if wearing_color:
		_animated_sprite.play("wearing_color")
	else:
		_animated_sprite.play("default")
