extends classCharacter
class_name classCanster

onready var _audio_stream_player_2D := $AudioStreamPlayer2D

func _ready():
	var shape = _interact_collision_shape_2D.shape
	_interact_collision_shape_2D.shape = shape.duplicate(true)

func update_animation():
	var has_trash : int = local_variables.get("has_trash", 0)
	if has_trash:
		_animated_sprite.play("has_trash")
		var shape = _interact_collision_shape_2D.shape
		shape.extents = Vector2(24, 24)
		_audio_stream_player_2D.playing = false
	else:
		_animated_sprite.play("default")
		var shape = _interact_collision_shape_2D.shape
		shape.extents = Vector2(60, 60)
		_audio_stream_player_2D.playing = true
