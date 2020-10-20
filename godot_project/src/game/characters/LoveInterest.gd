extends classCharacter

enum CLOTHING {PLAIN, COLORFUL}

func _ready():
	register_state_property("wearing_color", CLOTHING.COLORFUL)

	update_animation()

func update_animation():
	var wearing_color : int = get_state_property("wearing_color")
	var state_settings : Dictionary = _state_machine.get(wearing_color, {})
	_animated_sprite.play(state_settings.get("animation_name", "idle_color"))

var _state_machine := {
	CLOTHING.COLORFUL: {
		"animation_name": "idle_color"
	},
	CLOTHING.PLAIN: {
		"animation_name": "idle"
	}
}
