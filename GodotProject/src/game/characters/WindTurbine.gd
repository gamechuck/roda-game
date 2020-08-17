extends class_character

enum STATE {BROKEN, FIXED}

var state : int = STATE.BROKEN setget set_state
func set_state(value : int) -> void:
	state = value
	_update_animation()

func _ready():
	_update_animation()

func _update_animation():
	var state_settings : Dictionary = _state_machine.get(state, {})
	_animated_sprite.play(state_settings.get("animation_name", "fixed"))

var _state_machine := {
	STATE.BROKEN:{
		"animation_name": "broken"
	},
	STATE.FIXED:{
		"animation_name": "fixed"
	}
}
