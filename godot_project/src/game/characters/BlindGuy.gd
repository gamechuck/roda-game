extends classCharacter

enum MOVING {IDLE, WALK}

var _moving : int = MOVING.IDLE

func _ready():
	update_animation()

func update_state(move_direction : Vector2 = Vector2.ZERO):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_moving : int = _moving

	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			_moving = MOVING.WALK
		elif normalized_direction.x < 0:
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			_moving = MOVING.WALK
		elif normalized_direction.y < 0:
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	else:
		_moving = MOVING.IDLE

	if old_moving != _moving:
		update_animation()

func update_animation():
	var animations : Dictionary = default_animations.get(_moving, {})

	_animated_sprite.play(animations.get("animation_name", "idle_down"))

var default_animations := {
		MOVING.IDLE:{
			"animation_name": "idle_down"
		},
		MOVING.WALK:{
			"animation_name": "walk_down"
		}
}