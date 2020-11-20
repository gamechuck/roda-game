extends classCharacter

func _ready():
	update_animation()

func update_animation():
	match State.level_state:
		State.LEVEL.MAIN:
			var mr_smog_defeated : int = local_variables.get("mr_smog_defeated", 0)
			if mr_smog_defeated:
				set_visible(true)
			else:
				set_visible(false)
		_:
			set_visible(true)
