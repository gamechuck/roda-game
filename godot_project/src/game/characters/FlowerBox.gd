extends classCharacter

func _ready():
	update_animation()

func update_animation():
	match State.level_state:
		State.LEVEL.MAIN:
			var rose_seeds_planted : int = local_variables.get("rose_seeds_planted", 0)
			if rose_seeds_planted:
				_animated_sprite.play("rose_seeds_planted")
			else:
				_animated_sprite.play("default")
		_:
			_animated_sprite.play("rose_seeds_planted")
