extends Area2D
class_name class_skater

onready var _tween := $Tween

var initial_offset := 0.0
var path_follow : PathFollow2D = null

func _ready():
	var parent = path_follow.get_parent()
	if parent is Path2D:
		var curve : Curve2D = parent.curve
		if curve != null:
			var duration : float = curve.get_baked_length()
			if not Engine.editor_hint:
				duration /= Flow.SKATER_MOVE_SPEED
			else:
				duration /= 1.0
			duration /= ProjectSettings.get("physics/common/physics_fps")

			_tween.interpolate_method(self, "set_unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			_tween.repeat = true
			_tween.seek(initial_offset*duration)
			_tween.start()

func set_unit_offset(value : float):
#	var old_position := path_follow.position
	path_follow.unit_offset = value
#	var direction : Vector2 = path_follow.position - old_position
#	update_state(direction.normalized())
