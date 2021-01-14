class_name classPlayer
extends classCharacter

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _moving : int = MOVING.IDLE
var _direction : int = DIRECTION.DOWN

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []

var _overlapping_character : classCharacter = null
var _overlapping_pickup : classPickup = null
var _overlapping_with_gummy := false

var _target_entity : CollisionObject2D = null

onready var _interact_area := $InteractArea
onready var _bump_area := $BumpArea

signal nav_path_requested

signal dialogue_requested
signal cutscene_requested

func _ready():
	Flow.player = self
	is_player = true
	respawn_position = position

	var _error := _interact_area.connect("area_entered", self, "_on_interact_area_entered")
	_error = _interact_area.connect("area_exited", self, "_on_interact_area_exited")

	_error = _bump_area.connect("area_entered", self, "_on_bump_area_entered")

	_error = connect("dialogue_requested", Director, "_on_dialogue_requested")
	_error = connect("cutscene_requested", Director, "_on_cutscene_requested")

	_error = Director.connect("revoke_player_autonomy", self, "_on_autonomy_revoked")
	_error = Director.connect("grant_player_autonomy", self, "_on_autonomy_granted")

	# Block the player autonomy if a cutscene is still in progress!
	if Director.cutscene_in_progress:
		_on_autonomy_revoked()
	update_animation()

func _on_autonomy_revoked():
	set_physics_process(false)
	set_process_unhandled_input(false)

	# One extra animation update to force idle!
	update_state()
	nav_path = PoolVector2Array()

func _on_autonomy_granted():
	set_physics_process(true)
	set_process_unhandled_input(true)

func _physics_process(delta):
	if not Flow.is_in_editor_mode:
		var move_direction := Vector2.ZERO
		var move_speed := get_move_speed()

		if Input.is_action_pressed("move_down"):
			move_direction.y += 1
		if Input.is_action_pressed("move_up"):
			move_direction.y -= 1
		if Input.is_action_pressed("move_left"):
			move_direction.x -= 1
		if Input.is_action_pressed("move_right"):
			move_direction.x += 1

		if not move_direction == Vector2.ZERO:
			nav_path = PoolVector2Array()
			_target_entity = null

		if nav_path.size() > 0:
			var distance := position.distance_to(nav_path[0])
			if distance > ConfigData.PLAYER_MOVE_SPEED * delta:
				var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
				move_direction = new_position - position
			else:
				nav_path.remove(0)

		update_state(move_direction)
		var normalized_direction := move_direction.normalized()
		var _linear_velocity := move_and_slide(normalized_direction*move_speed)

func _unhandled_input(event):
## Inputs that are NOT handled by any of the UI elements!
	if event.is_action_pressed("interact"):
		if _overlapping_character and _overlapping_character != self:
			emit_signal("dialogue_requested", _overlapping_character)
		elif _overlapping_pickup:
			emit_signal("dialogue_requested", _overlapping_pickup)
			Flow.inventory.add_item(_overlapping_pickup)

	if event.is_action_pressed("toggle_inventory"):
		Flow.toggle_inventory()

	if event.is_action_released("left_mouse_button"):
		_target_entity = null
		if Flow.active_character != null:
			process_interaction(Flow.active_character)
			Flow.active_character = null
		elif Flow.active_pickup != null:
			process_interaction(Flow.active_pickup)
			Flow.active_pickup = null
		elif Flow.player_is_active and Flow.active_item != null:
			process_interaction(self)
			Flow.active_pickup = null
		else:
			emit_signal("nav_path_requested")

func process_interaction(active_entity : CollisionObject2D):
	var entity_position = active_entity.position
	var distance : float = position.distance_to(entity_position)
	print("Distance to entity ('{0}') is {1}".format([active_entity.name, distance]))
	if distance > ConfigData.MINIMUM_INTERACTION_DISTANCE:
		_target_entity = active_entity
		emit_signal("nav_path_requested")
	elif Flow.active_item != null:
		var item : classItemState = Flow.active_item
		var item_id = item.id
		emit_signal("dialogue_requested", active_entity, item_id)
		Flow.inventory.reset_slots()
	elif Flow.active_character != self:
		emit_signal("dialogue_requested", active_entity)
		if active_entity is classPickup:
			Flow.inventory.add_item(active_entity)

func _on_interact_area_entered(area):
	if not area:
		return

	if area.get_parent() is classCharacter:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()
		if _overlapping_character == _target_entity:
			process_interaction(_overlapping_character)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is classPickup:
		#respawn_position = position
		print("Player entered the item!")
		_overlapping_pickup = area
		if _overlapping_pickup == _target_entity:
			process_interaction(_overlapping_pickup)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is classGummy:
		_overlapping_with_gummy = true
		if local_variables.get("player_noted_gummy", 0) == 0:
			update_state()
			Director.start_knot_dialogue(self, "conv_gummy")
		print("Player entered gummy!")
	elif area is classSafeZone:
		respawn_position = area.position
		print("Player entered a safe zone!")

func _on_interact_area_exited(area):
	if not area:
		return

	if area.get_parent() is classCharacter:
		print("Player exited a character's interact area!")
		if _overlapping_character == area.get_parent():
			_overlapping_character = null
	if area is classPickup:
		#respawn_position = position
		print("Player exited the item!")
		if _overlapping_pickup == area:
			_overlapping_pickup = null
	if area is classGummy:
		_overlapping_with_gummy = false
		print("Player exited gummy!")

func _on_bump_area_entered(area : Area2D):
# Stuff that should really be precise should be added here!
	if not area:
		return

	if area.get_parent() is classCanster:
		var canster : classCanster = area.get_parent()
		if not canster.is_appeased():
			# The canster is angry!!!
			process_interaction(canster)
			_target_entity = null
			nav_path = PoolVector2Array()
			print("Player got eaten by a canster!")


	if area is classCar:
		emit_signal("cutscene_requested", "respawn")
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	elif area is classSkater:
		emit_signal("cutscene_requested", "respawn")
		nav_path = PoolVector2Array()
		print("Player got hit by a skater!")
	elif area is classProjectile:
		emit_signal("cutscene_requested", "respawn")
		nav_path = PoolVector2Array()
		print("Player got hit by a projectile!")
	elif area.get_parent() is classCanster:
		var canster = area.get_parent()
		if canster.local_variables.get("has_trash", 0) == 0:
			# The canster is angry!!!
			process_interaction(canster)
			_target_entity = null
			nav_path = PoolVector2Array()
			print("Player got eaten by a canster!")

func get_move_speed() -> float:
	var move_speed := ConfigData.PLAYER_MOVE_SPEED
	if local_variables.get("player_on_bike", 0):
		move_speed *= ConfigData.BIKE_MODIFIER
	elif _overlapping_with_gummy:
		move_speed *= ConfigData.GUMMY_MODIFIER
	return move_speed

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
	var wearing_color : int = local_variables.get("player_wearing_color", 0)
	var on_bike : int = local_variables.get("player_on_bike", 0)

	var animations := {}
	if wearing_color:
		if on_bike:
			animations = colorful_on_bike_animations
		else:
			animations = colorful_on_foot_animations
	else:
		if on_bike:
			animations = plain_on_bike_animations
		else:
			animations = plain_on_foot_animations

	animations = animations.get(_direction, {})
	animations = animations.get(_moving, {})

	_animated_sprite.play(animations.get("animation_name", "default"))
	_animated_sprite.flip_h = animations.get("flip_h", false)
	_animated_sprite.flip_v = animations.get("flip_v", false)

var colorful_on_foot_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE: {
			"animation_name": "idle_right_color",
			"flip_h": true
		},
		MOVING.WALK: {
			"animation_name": "walk_right_color",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE: {
			"animation_name": "idle_right_color",
		},
		MOVING.WALK: {
			"animation_name": "walk_right_color",
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE: {
			"animation_name": "idle_up_color"
		},
		MOVING.WALK: {
			"animation_name": "walk_up_color"
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE: {
			"animation_name": "idle_down_color"
		},
		MOVING.WALK: {
			"animation_name": "walk_down_color"
		}
	}
}

var colorful_on_bike_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE: {
			"animation_name": "cycle_right_idle_color",
			"flip_h": true
		},
		MOVING.WALK: {
			"animation_name": "cycle_right_color",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE: {
			"animation_name": "cycle_right_idle_color",
		},
		MOVING.WALK: {
			"animation_name": "cycle_right_color",
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE: {
			"animation_name": "cycle_up_idle_color"
		},
		MOVING.WALK: {
			"animation_name": "cycle_up_color"
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE: {
			"animation_name": "cycle_down_idle_color"
		},
		MOVING.WALK: {
			"animation_name": "cycle_down_color"
		}
	}
}

var plain_on_bike_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE: {
			"animation_name": "cycle_right_idle",
			"flip_h": true
		},
		MOVING.WALK: {
			"animation_name": "cycle_right",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE: {
			"animation_name": "cycle_right_idle",
		},
		MOVING.WALK: {
			"animation_name": "cycle_right",
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE: {
			"animation_name": "cycle_up_idle"
		},
		MOVING.WALK: {
			"animation_name": "cycle_up"
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE: {
			"animation_name": "cycle_down_idle"
		},
		MOVING.WALK: {
			"animation_name": "cycle_down"
		}
	}
}

var plain_on_foot_animations := {
	DIRECTION.LEFT:{
		MOVING.IDLE: {
			"animation_name": "idle_right",
			"flip_h": true
		},
		MOVING.WALK: {
			"animation_name": "walk_right",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		MOVING.IDLE: {
			"animation_name": "idle_right",
		},
		MOVING.WALK: {
			"animation_name": "walk_right",
		}
	},
	DIRECTION.UP:{
		MOVING.IDLE: {
			"animation_name": "idle_up"
		},
		MOVING.WALK: {
			"animation_name": "walk_up"
		}
	},
	DIRECTION.DOWN:{
		MOVING.IDLE: {
			"animation_name": "idle_down"
		},
		MOVING.WALK: {
			"animation_name": "walk_down"
		}
	}
}



