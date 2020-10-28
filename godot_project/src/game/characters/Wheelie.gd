extends classCharacter

onready var _tween := $Tween
onready var _interact_area := $InteractArea

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _direction : int = DIRECTION.DOWN
var _moving : int = MOVING.IDLE

var nav_path : PoolVector2Array = []

var target_points : PoolVector2Array = [
	Vector2(2480, 2360),
	Vector2(3474, 2360),
	Vector2(3424, 2248),
	Vector2(3497, 2021),
	Vector2(3818, 2018),
	Vector2(4020, 1742),
	Vector2(4020, 1767)
	]

var current_idx := 0
var target_idx := 0
var got_scared := false
var its_over := false

signal nav_path_requested

func _ready():
	var _error := _interact_area.connect("area_entered", self, "_on_area_entered")

	set_physics_process(false)

	_update_animation()

func _physics_process(_delta):
	if its_over:
		set_physics_process(false)
		its_over = false
		return

	var move_direction := Vector2.ZERO
	var move_speed := get_move_speed()

	if nav_path.size() > 0:
		var distance := position.distance_to(nav_path[0])
		if distance > move_speed:
			var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
			move_direction = new_position - position
		else:
			nav_path.remove(0)
	else:
		process_next_point()

	update_state(move_direction)
	var normalized_direction := move_direction.normalized()
	var _linear_velocity := move_and_slide(normalized_direction*move_speed/_delta)

func process_next_point():
	if target_idx > current_idx:
		current_idx += 1
	elif target_idx < current_idx:
		current_idx -= 1
	else:
		its_over = true
		set_physics_process(false)
		set_state_property("going_to_house", 0)
		set_state_property("going_back_to_park", 0)
		if got_scared:
			set_state_property("arrived_safely", 0)
			got_scared = false
		else:
			set_state_property("arrived_safely", 1)
		return

	emit_signal("nav_path_requested", target_points[current_idx])

func get_move_speed() -> float:
	var move_speed := ConfigData.wheelie_move_speed
	if got_scared:
		move_speed *= 4
	return move_speed

func _on_area_entered(area):
	if not area:
		return

	if area.get_parent() is classCanster:
		var canster = area.get_parent()
		if canster.get_state_property("is_appeased") == 0:
			nav_path = PoolVector2Array()
			got_scared = true
			if target_idx == target_points.size() - 1:
				target_idx = 0
			elif target_idx == 0:
				target_idx = target_points.size() - 1

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
	if get_state_property("going_to_house") == 1:
		current_idx = 0
		target_idx = target_points.size() - 1
		set_physics_process(true)
	elif get_state_property("going_back_to_park") == 1:
		current_idx = target_points.size() - 1
		target_idx = 0
		set_physics_process(true)

func _update_animation():
	var animations : Dictionary = default_animations.get(_direction, {})
	animations = animations.get(_moving, {})

	_animated_sprite.play(animations.get("animation_name", "idle_down"))
	_animated_sprite.flip_h = animations.get("flip_h", false)
	_animated_sprite.flip_v = animations.get("flip_v", false)

var default_animations := {
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

