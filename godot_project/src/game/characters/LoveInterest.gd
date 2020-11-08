extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var player_wearing_color : int = local_variables.get("player_wearing_color", 0)
	if not player_wearing_color:
		_animated_sprite.play("wearing_color")
	else:
		_animated_sprite.play("default")
