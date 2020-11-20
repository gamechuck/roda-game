extends classCharacter

func _ready():
	update_animation()

func update_animation():
	match State.level_state:
		State.LEVEL.MAIN:
			var bike_returned : int = local_variables.get("bike_returned", 0)
			var bike_taken : int = local_variables.get("bike_taken", 0)
			if bike_returned and not bike_taken:
				set_visible(true)
			else:
				set_visible(false)
		_:
			set_visible(true)
