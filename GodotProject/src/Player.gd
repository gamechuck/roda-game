extends KinematicBody2D
class_name class_player

enum STATE {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var _direction : int = DIRECTION.DOWN
var _state : int = STATE.IDLE

var bias : float = 0.0

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []
var is_in_gummy := false
var is_in_dialogue := false
var is_in_cutscene := false setget set_is_in_cutscene
func set_is_in_cutscene(value : bool):
	is_in_cutscene = value
	set_process_unhandled_input(not is_in_cutscene)
var is_on_bike := true

var _overlapping_character : class_character = null
var _overlapping_item : class_item = null

var _target_entity : CollisionObject2D = null

onready var _interact_area := $InteractArea
onready var _animated_sprite := $AnimatedSprite
onready var _tween := $Tween

signal nav_path_requested

func _ready():
	Flow.player = self
	respawn_position = position

	var _success := _interact_area.connect("area_shape_entered", self, "_on_area_shape_entered")
	_success = _interact_area.connect("area_shape_exited", self, "_on_area_shape_exited")
	#_success = _tween.connect("tween_all_completed", self, "_on_tween_all_completed")

func _physics_process(_delta):
	if not Flow.is_in_editor_mode:
		var move_direction := Vector2.ZERO
		var move_speed := get_move_speed()

		#print(is_in_dialogue)

		if not is_in_dialogue and not is_in_cutscene:
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
				if distance > Flow.PLAYER_MOVE_SPEED:
					var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
					move_direction = new_position - position
				else:
					nav_path.remove(0)

		update_state(move_direction)
		var normalized_direction := move_direction.normalized()
		var _linear_velocity := move_and_slide(normalized_direction*move_speed/_delta)

#		for i in get_slide_count():
#			var collision = get_slide_collision(i)
#			print("I collided with ", collision.collider.name)

func _unhandled_input(event):
## Inputs that are NOT handled by any of the UI elements!

	if event.is_action_pressed("interact"):
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
			if not is_in_dialogue:
				_tween.set_active(true)
		elif _overlapping_character != null:
			is_in_dialogue = Flow.dialogue_UI.start_interact_dialogue(_overlapping_character)
		elif _overlapping_item != null:
			is_in_dialogue = Flow.dialogue_UI.start_interact_dialogue(_overlapping_item)
			Flow.inventory_overlay.add_item(_overlapping_item)

	if event.is_action_pressed("toggle_inventory"):
		Flow.inventory_overlay.toggle_inventory()

	if event.is_action_pressed("left_mouse_button"):
		_target_entity = null
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
			if not is_in_dialogue:
				_tween.set_active(true)
			Flow.active_character = null
			Flow.active_item = null
		elif Flow.active_character != null:
			process_interaction(Flow.active_character)
			Flow.active_character = null
		elif Flow.active_item != null:
			process_interaction(Flow.active_item)
			Flow.active_item = null
		else:
			emit_signal("nav_path_requested")

func process_interaction(active_entity : CollisionObject2D):
	var entity_position = active_entity.position
	var distance : float = position.distance_to(entity_position)
	print("Distance to entity ('{0}') is {1}".format([active_entity.name, distance]))
	if distance > Flow.MINIMUM_INTERACTION_DISTANCE:
		_target_entity = active_entity
		emit_signal("nav_path_requested")
	elif Flow.active_inventory_item != null:
		var inventory_item : class_inventory_item = Flow.active_inventory_item
		var item_id = inventory_item.id
		is_in_dialogue = \
			Flow.dialogue_UI.start_use_item_dialogue(active_entity, item_id)
		Flow.active_inventory_item.pressed = false
		Flow.active_inventory_item = null
	else:
		is_in_dialogue = Flow.dialogue_UI.start_interact_dialogue(active_entity)
		print(active_entity.name)
		if active_entity is class_item:
			Flow.inventory_overlay.add_item(active_entity)

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return
	if is_in_cutscene:
		return

	if area is class_car:
		#position = respawn_position
		play_respawn_cutscene()
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	elif area is class_skater:
		#position = respawn_position
		play_respawn_cutscene()
		nav_path = PoolVector2Array()
		print("Player got hit by a skater!")
	elif area.get_parent() is class_character:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()
		if _overlapping_character == _target_entity or \
		_overlapping_character is class_canster and _overlapping_character.state == class_canster.STATE.ANGRY:
			process_interaction(_overlapping_character)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is class_item:
		#respawn_position = position
		print("Player entered the item!")
		_overlapping_item = area
		if _overlapping_item == _target_entity:
			process_interaction(_overlapping_item)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is class_gummy:
		is_in_gummy = true
		print("Player entered gummy!")
	elif area is class_safe_zone:
		respawn_position = area.position
		print("Player entered a safe zone!")

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return

	if area.get_parent() is class_character:
		print("Player exited a character's interact area!")
		if _overlapping_character == area.get_parent():
			_overlapping_character = null
	if area is class_item:
		#respawn_position = position
		print("Player exited the item!")
		if _overlapping_item == area:
			_overlapping_item = null
	if area is class_gummy:
		is_in_gummy = false
		print("Player exited gummy!")

func get_move_speed() -> float:
	var move_speed := Flow.PLAYER_MOVE_SPEED
	if is_in_gummy:
		move_speed *= Flow.GUMMY_MODIFIER
	if is_on_bike:
		move_speed *= Flow.BIKE_MODIFIER
	return move_speed

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_state : int = _state
	var old_direction : int = _direction
	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			_direction = DIRECTION.RIGHT
			_state = STATE.WALK
		elif normalized_direction.x < 0:
			_direction = DIRECTION.LEFT
			_state = STATE.WALK
		else:
			_state = STATE.IDLE
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			_direction = DIRECTION.DOWN
			_state = STATE.WALK
		elif normalized_direction.y < 0:
			_direction = DIRECTION.UP
			_state = STATE.WALK
		else:
			_state = STATE.IDLE
	else:
		_state = STATE.IDLE

	if old_state != _state or old_direction != _direction:
		update_animation()

func update_animation():
	var direction_settings : Dictionary = state_machine.get(_direction, {})
	var state_settings : Dictionary = direction_settings.get(_state, {})

	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

var state_machine := {
	DIRECTION.LEFT:{
		STATE.IDLE:{
			"animation_name": "idle_right",
			"flip_h": true
		},
		STATE.WALK:{
			"animation_name": "walk_right",
			"flip_h": true
		}
	},
	DIRECTION.RIGHT:{
		STATE.IDLE:{
			"animation_name": "idle_right"
		},
		STATE.WALK:{
			"animation_name": "walk_right"
		}
	},
	DIRECTION.UP:{
		STATE.IDLE:{
			"animation_name": "idle_up"
		},
		STATE.WALK:{
			"animation_name": "walk_up"
		}
	},
	DIRECTION.DOWN:{
		STATE.IDLE:{
			"animation_name": "idle_down"
		},
		STATE.WALK:{
			"animation_name": "walk_down"
		}
	}
}

func play_respawn_cutscene():
	var delay := 0.0
	var duration := 1.0
	self.is_in_cutscene = true

	_tween.interpolate_property(
		$AnimatedSprite, 
		"position", 
		$AnimatedSprite.position, 
		$AnimatedSprite.position + Vector2(0, -200),
		duration, 
		Tween.TRANS_BACK, 
		Tween.EASE_OUT)
	_tween.interpolate_property(
		$AnimatedSprite, 
		"rotation_degrees", 
		$AnimatedSprite.rotation_degrees, 
		0, 
		duration, 
		Tween.TRANS_CUBIC, 
		Tween.EASE_OUT)
	delay += duration

	_tween.interpolate_property(
		self,
		"position", 
		position, 
		respawn_position, 
		0.0, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT, 
		delay)
	_tween.interpolate_property(
		$AnimatedSprite, 
		"position", 
		$AnimatedSprite.position + Vector2(0, -200), 
		Vector2(0, -200), 
		0.0, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT, 
		delay)
	_tween.interpolate_property(
		$AnimatedSprite, 
		"position", 
		Vector2(0, -200), 
		Vector2.ZERO, 
		duration, 
		Tween.TRANS_BOUNCE, 
		Tween.EASE_OUT, 
		delay)
	delay += duration

	_tween.interpolate_property(
		self, 
		"is_in_cutscene", 
		true, 
		false,
		0.0, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT, 
		delay)
	_tween.start()

func play_chewing_cutscene(canster : class_canster):
	var delay := 0.0
	var duration := 0.5
	self.is_in_cutscene = true

	var target_position = canster.position - position
	target_position.y -= 40
	_tween.interpolate_property(
		$AnimatedSprite, 
		"position", 
		Vector2.ZERO, 
		target_position, 
		duration, 
		Tween.TRANS_CUBIC, 
		Tween.EASE_OUT)
	_tween.interpolate_property(
		$AnimatedSprite, 
		"rotation_degrees", 
		$AnimatedSprite.rotation_degrees, 
		180, 
		duration, 
		Tween.TRANS_CUBIC, 
		Tween.EASE_OUT)
	delay += duration

	duration = 2.0
	bias = target_position.y
	_tween.interpolate_method(
		self, 
		"_sinusoidal_movement", 
		0, 
		4, 
		duration, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN, 
		delay)
	delay += duration
	_tween.interpolate_callback(
		self,
		delay,
		"update_cutscene_dialogue")
	_tween.interpolate_property(
		self, 
		"is_in_cutscene", 
		true, 
		false,
		0.0, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT, 
		delay)
	_tween.start()

func _sinusoidal_movement(time : float):
	var amplitude := 10
	$AnimatedSprite.position.y = amplitude*sin(2*PI*1*time) + bias

func update_cutscene_dialogue():
	is_in_dialogue = Flow.dialogue_UI.update_dialogue()
