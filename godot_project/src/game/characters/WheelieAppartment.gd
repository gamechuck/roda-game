extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var wheelie_appartment_opened : int = local_variables.get("wheelie_appartment_opened", 0)
	if wheelie_appartment_opened:
		print("updating wheelie")
		_animated_sprite.play("wheelie_appartment_opened")
		visible = true
	else:
		_animated_sprite.play("default")
		visible = true
