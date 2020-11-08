extends classCharacter

# Is this the protesting version of the character?
export(bool) var protesting := false

func _ready():
	update_animation()

func update_animation():
	match State.level_state:
		State.LEVEL.MAIN:
			var student_gone_protesting : int = local_variables.get("student_gone_protesting", 0)
			if student_gone_protesting and protesting:
				set_visible(true)
			elif not student_gone_protesting and not protesting:
				set_visible(true)
			else:
				set_visible(false)
