tool
extends classCharacter

enum TYPE {MIXED, PLASTIC, PAPER}

export(TYPE) var type := TYPE.MIXED setget set_type
func set_type(value : int):
	type = value
	if is_inside_tree():
		update_container()

func _ready():
	update_container()

	if not Engine.editor_hint:
		call_deferred("update_animation")

func update_animation():
	var animations := {}

	if local_variables.get("operation_better_park_started", false):
		set_visible(true)
	else:
		set_visible(false)

func update_container():
	match type:
		TYPE.MIXED:
			$AnimatedSprite.play("mixed")
		TYPE.PLASTIC:
			$AnimatedSprite.play("plastic")
		TYPE.PAPER:
			$AnimatedSprite.play("paper")
		_:
			$AnimatedSprite.play("mixed")
