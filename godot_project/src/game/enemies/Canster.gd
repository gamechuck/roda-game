extends classCharacter
class_name classCanster

enum MOOD {ANGRY, HAPPY}

onready var _audio_stream_player_2D := $AudioStreamPlayer2D

func _ready():
	register_state_property("is_appeased", MOOD.ANGRY)

	var shape = _interact_collision_shape_2D.shape
	_interact_collision_shape_2D.shape = shape.duplicate(true)

	update_animation()

func update_animation():
	var is_appeased : int = get_state_property("is_appeased")
	var state_settings : Dictionary = _state_machine.get(is_appeased, {})
	_animated_sprite.play(state_settings.get("animation_name", "aggressive"))

	var shape = _interact_collision_shape_2D.shape
	shape.extents = state_settings.get("extents", Vector2(24, 24))

	_audio_stream_player_2D.playing = state_settings.get("playing", false)

var _state_machine := {
	MOOD.ANGRY: {
		"animation_name": "aggressive",
		"extents": Vector2(60, 60),
		"playing" : true
	},
	MOOD.HAPPY: {
		"animation_name": "friendly",
		"extents": Vector2(24, 24),
		"playing" : false
	}
}
