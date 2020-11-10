extends classCharacter

onready var _interact_area := $InteractArea

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _moving : int = MOVING.IDLE
var _direction : int = DIRECTION.DOWN

var nav_path : PoolVector2Array = []
var waypoint_ids : PoolStringArray = [
	"wheelie1",
	"wheelie2",
	"wheelie3",
	"wheelie4",
	"wheelie5",
	"wheelie6",
	"wheelie7"
	]

var index := 0
var target_index := 0

signal nav_path_requested

func _ready():
	var _error := _interact_area.connect("body_entered", self, "_on_body_entered")

	set_physics_process(false)

	_update_animation()

func _physics_process(delta : float) -> void:
	var move_direction := Vector2.ZERO
	var move_speed := get_move_speed()

	if nav_path.size() > 0:
		var distance := position.distance_to(nav_path[0])
		if distance > ConfigData.WHEELIE_MOVE_SPEED * delta:
			var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
			move_direction = new_position - position
		else:
			nav_path.remove(0)
	else:
		process_next_point()

	update_state(move_direction)
	var normalized_direction := move_direction.normalized()
	var _linear_velocity := move_and_slide(normalized_direction*move_speed)

func process_next_point() -> void:
	if target_index > index:
		index += 1
	elif target_index < index:
		index -= 1
	else:
		if not local_variables.get("wheelie_got_scared", 0):
			if local_variables.get("wheelie_going_to_house", 0):
				set_story_variable("wheelie_arrived_at_house", 1)
			elif local_variables.get("wheelie_going_to_park", 0):
				set_story_variable("wheelie_arrived_at_park", 1)
		# Reset Wheelie!
		set_story_variable("wheelie_going_to_house", 0)
		set_story_variable("wheelie_going_to_park", 0)
		set_story_variable("wheelie_got_scared", 0)

		set_physics_process(false)
		return

	var target_position : Vector2 = Flow.get_waypoint_position(waypoint_ids[index])
	emit_signal("nav_path_requested", target_position)

func get_move_speed() -> float:
	var move_speed := ConfigData.WHEELIE_MOVE_SPEED
	if local_variables.get("wheelie_got_scared", 0):
		move_speed *= ConfigData.SCARED_MODIFIER
	return move_speed

func _on_body_entered(body : CollisionObject2D):
	if body is classCanster:
		if not body.is_appeased():
			nav_path = PoolVector2Array()
			set_story_variable("wheelie_got_scared", 1)
			if local_variables.get("wheelie_going_to_house", 0):
				set_story_variable("wheelie_going_to_house", 0)
				set_story_variable("wheelie_going_to_park", 1)
				target_index = 0
			elif local_variables.get("wheelie_going_to_park", 0):
				set_story_variable("wheelie_going_to_house", 1)
				set_story_variable("wheelie_going_to_park", 0)
				target_index = waypoint_ids.size() - 1

func update_state(move_direction : Vector2):
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
		_update_animation()

func update_animation():
	if local_variables.get("wheelie_going_to_house", 0) == 1:
		index = 0
		target_index = waypoint_ids.size() - 1
		set_physics_process(true)
	elif local_variables.get("wheelie_going_to_park", 0) == 1:
		index = waypoint_ids.size() - 1
		target_index = 0
		set_physics_process(true)

	_update_animation()

func _update_animation():
	var animations := {}

	if local_variables.get("operation_better_park_started", 0):
		animations = protesting_animations
	else:
		animations = default_animations.get(_direction, {})
		animations = animations.get(_moving, {})

	_animated_sprite.play(animations.get("animation_name", "idle_down"))
	_animated_sprite.flip_h = animations.get("flip_h", false)
	_animated_sprite.flip_v = animations.get("flip_v", false)

var protesting_animations := {
	"animation_name": "protesting",
	"offset": Vector2(0, -62)
}

var default_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE:{
			"animation_name": "idle_left",
			"offset": Vector2(0, -42)
		},
		MOVING.WALK:{
			"animation_name": "walk_left",
			"offset": Vector2(0, -42)
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE:{
			"animation_name": "idle_left",
			"flip_h": true,
			"offset": Vector2(0, -42)
		},
		MOVING.WALK:{
			"animation_name": "walk_left",
			"flip_h": true,
			"offset": Vector2(0, -42)
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE:{
			"animation_name": "idle_up",
			"offset": Vector2(0, -42)
		},
		MOVING.WALK:{
			"animation_name": "walk_up",
			"offset": Vector2(0, -42)
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE:{
			"animation_name": "idle_down",
			"offset": Vector2(0, -42)
		},
		MOVING.WALK:{
			"animation_name": "walk_down",
			"offset": Vector2(0, -42)
		}
	}
}

