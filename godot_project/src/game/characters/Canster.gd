extends classCharacter
class_name classCanster

onready var _audio_stream_player_2D := $AudioStreamPlayer2D

func _ready():
	var shape = _interact_collision_shape_2D.shape
	_interact_collision_shape_2D.shape = shape.duplicate(true)

	call_deferred("update_animation")

func is_appeased() -> bool:
	for key in local_variables.keys():
		if key.ends_with("appeased"):
			return bool(local_variables[key])
	return false

func update_animation():
	var animations := {}

	var is_appeased : int = is_appeased()
	if is_appeased:
		animations = animations_dict.get("appeased", {})
	else:
		animations = animations_dict.get("default", {})

	_animated_sprite.play(animations.get("animation_name", "default"))

	var shape = _interact_collision_shape_2D.shape
	shape.extents = animations.get("extents", Vector2(24, 24))

	if local_variables.get("operation_better_park_started", true):
		_audio_stream_player_2D.playing = animations.get("audio_playing", true)
		set_visible(false)
	else:
		# Don't play any sound when the Canster is invisible!
		_audio_stream_player_2D.playing = false
		set_visible(true)

var animations_dict := {
	"default":
		{
			"animation_name": "default",
			"extents": Vector2(36, 36),
			"audio_playing": true
		},
	"appeased":
		{
			"animation_name": "appeased",
			"extents": Vector2(24, 24),
			"audio_playing": false
		}
}
