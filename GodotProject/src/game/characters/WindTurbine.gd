extends class_character

enum POWER {EMPTY, FULL}

func _ready():
	register_state_property("is_powered", POWER.EMPTY)

func update_animation():
	var is_powered : int = get_state_property("is_powered")
	var state_settings : Dictionary = _state_machine.get(is_powered, {})
	_animated_sprite.play(state_settings.get("animation_name", "broken"))

var _state_machine := {
	POWER.EMPTY:{
		"animation_name": "broken"
	},
	POWER.FULL:{
		"animation_name": "fixed"
	}
}
