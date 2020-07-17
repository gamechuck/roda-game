extends class_character
class_name class_canster

enum STATE {ANGRY = 0, APPEASED = 1}

const ANGRY_EXTENTS := Vector2()

var state : int = STATE.ANGRY setget set_state
func set_state(value : int) -> void:
	state = value
	_update_animation()

func _ready():
	_update_animation()

func _update_animation():
	var state_settings : Dictionary = _state_machine.get(state, {})
	_animated_sprite.play(state_settings.get("animation_name", "angry"))

	var shape = _interact_collision_shape_2D.shape
	shape.extents = state_settings.get("extents", Vector2(24, 24))

var _state_machine := {
	STATE.ANGRY:{
		"animation_name": "angry",
		"extents": Vector2(60, 60)
	},
	STATE.APPEASED:{
		"animation_name": "appeased",
		"extents": Vector2(24, 24)
	}
}
