extends classCharacter

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _moving : int = MOVING.IDLE
var _direction : int = DIRECTION.DOWN

var nav_path : PoolVector2Array = []

signal nav_path_requested

func _ready():
	$Line2D.add_point(Vector2.ZERO)
	$Line2D.add_point(Vector2.ZERO)

	update_animation()

func _physics_process(delta):
	$Line2D.set_point_position(1, Flow.player.position - global_position)

	var player : classPlayer = Flow.player
	var player_position : Vector2 = Flow.player.position

	var player_direction : int = player._direction
	match player_direction:
		DIRECTION.LEFT:
			player_position += Vector2(0, 20)
		DIRECTION.RIGHT:
			player_position += Vector2(0, 20)
		DIRECTION.UP:
			player_position += Vector2(-20, 0)
		DIRECTION.DOWN:
			player_position += Vector2(20, 0)

	emit_signal("nav_path_requested", player_position)

	var move_direction := Vector2.ZERO
	var move_speed := ConfigData.DOG_MOVE_SPEED

	if nav_path.size() > 0:
		var distance := position.distance_to(nav_path[0])
		if distance > move_speed * delta:
			var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
			move_direction = new_position - position
		else:
			nav_path.remove(0)
	else:
		pass

	update_state(move_direction)
	var normalized_direction := move_direction.normalized()
	var _linear_velocity := move_and_slide(normalized_direction*move_speed)

func update_state(move_direction : Vector2 = Vector2.ZERO):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_moving : int = _moving
	var old_direction : int = _direction

	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			_direction = DIRECTION.RIGHT
			_moving = MOVING.WALK
		elif normalized_direction.x < 0:
			_direction = DIRECTION.LEFT
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			_direction = DIRECTION.DOWN
			_moving = MOVING.WALK
		elif normalized_direction.y < 0:
			_direction = DIRECTION.UP
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	else:
		_moving = MOVING.IDLE

	if old_moving != _moving or old_direction != _direction:
		update_animation()

func update_animation():
	var dog_walking_started : int = local_variables.get("dog_walking_started", 0)
	var dog_walking_completed : int = local_variables.get("dog_walking_completed", 0)
	if dog_walking_started and not dog_walking_completed:
		set_visible(true)
		var animations : Dictionary = default_animations.get(_direction, {})
		animations = animations.get(_moving, {})

		_animated_sprite.play(animations.get("animation_name", "idle_down"))
		_animated_sprite.flip_h = animations.get("flip_h", false)
		_animated_sprite.flip_v = animations.get("flip_v", false)
	else:
		set_visible(false)

var default_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE:{
			"animation_name": "idle_right",
			"flip_h": true
		},
		MOVING.WALK:{
			"animation_name": "walk_right",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE:{
			"animation_name": "idle_right"
		},
		MOVING.WALK:{
			"animation_name": "walk_right"
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
