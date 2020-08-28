extends class_character

onready var _tween := $Tween

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _direction : int = DIRECTION.DOWN
var _moving : int = MOVING.IDLE

var initial_offset := 0.0

#onready var path_follow : PathFollow2D = $".."

func _ready():
	update_animation()

#	var parent = path_follow.get_parent()
#	if parent is Path2D:
#		var curve : Curve2D = parent.curve
#		if curve != null:
#			var duration : float = curve.get_baked_length()
#			duration /= ConfigData.car_move_speed
#			duration /= ProjectSettings.get("physics/common/physics_fps")
#
#			_tween.interpolate_method(self, "set_unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			_tween.repeat = true
#			_tween.seek(initial_offset*duration)
#			_tween.start()
#
#func set_unit_offset(value : float):
#	var old_position := path_follow.position
#	path_follow.unit_offset = value
#	var direction : Vector2 = path_follow.position - old_position
#	update_state(direction.normalized())

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_state : int = _state
	var old_direction : int = _direction

	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			_direction = DIRECTION.RIGHT
			_state = MOVING.WALK
		elif normalized_direction.x < 0:
			_direction = DIRECTION.LEFT
			_state = MOVING.WALK
		else:
			_state = MOVING.IDLE
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			_direction = DIRECTION.DOWN
			_state = MOVING.WALK
		elif normalized_direction.y < 0:
			_direction = DIRECTION.UP
			_state = MOVING.WALK
		else:
			_state = MOVING.IDLE
	else:
		_state = MOVING.IDLE

	if old_state != _state or old_direction != _direction:
		update_animation()

func update_animation():
	var state_settings : Dictionary = state_machine.get(_direction, {})
	state_settings = state_settings.get(_moving, {})

	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

var state_machine := {
	DIRECTION.LEFT:{
		MOVING.IDLE:{
			"animation_name": "idle_left",
			"flip_h": true
		},
		MOVING.WALK:{
			"animation_name": "walk_left"
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE:{
			"animation_name": "idle_left",
			"flip_h": true
		},
		MOVING.WALK:{
			"animation_name": "walk_left",
			"flip_h": true
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE:{
			"animation_name": "idle_up"
		},
		MOVING.WALK:{
			"animation_name": "walk_up"
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE:{
			"animation_name": "idle_down"
		},
		MOVING.WALK:{
			"animation_name": "walk_down"
		}
	}
}

