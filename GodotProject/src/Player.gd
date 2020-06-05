extends KinematicBody2D
class_name class_player

enum STATE {DEFAULT, LEFT, RIGHT, UP, DOWN}

var player_state : int = STATE.DEFAULT

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []
var is_in_dialogue := false
var is_dragging_item := false
var is_in_gummy := false

var _overlapping_character : class_character = null
var _overlapping_item : class_item = null

onready var _interact_area := $InteractArea
onready var _animated_sprite := $AnimatedSprite

signal nav_path_requested

func _ready():
	var _success := _interact_area.connect("area_shape_entered", self, "_on_area_shape_entered")
	_success = _interact_area.connect("area_shape_exited", self, "_on_area_shape_exited")

func _physics_process(_delta):
	if not Flow.is_in_editor_mode:
		var move_direction := Vector2.ZERO
		var move_speed := get_move_speed()
		
		if not is_in_dialogue:
			if Input.is_action_pressed("move_down"):
				move_direction.y += 1
				nav_path = PoolVector2Array()
			if Input.is_action_pressed("move_up"):
				move_direction.y -= 1
				nav_path = PoolVector2Array()
			if Input.is_action_pressed("move_left"):
				move_direction.x -= 1
				nav_path = PoolVector2Array()
			if Input.is_action_pressed("move_right"):
				move_direction.x += 1
				nav_path = PoolVector2Array()
	
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

func _input(event):
	if event.is_action_pressed("interact"):
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
		elif _overlapping_character != null:
			is_in_dialogue = Flow.dialogue_UI.start_dialogue(_overlapping_character)
		elif _overlapping_item != null:
			# REMOVE THIS LOGIC HERE!!!
			var item_id := _overlapping_item.name
			var item_data := Flow.get_item_data(item_id)
			print(item_data)
			Flow.inventory_overlay.add_item(item_data)
			_overlapping_item.queue_free()
			_overlapping_item = null

	if event.is_action_pressed("toggle_inventory"):
		Flow.inventory_overlay.toggle_inventory()

func _unhandled_input(event):
## Inputs that are NOT handled by any of the UI elements!
	if Flow.item_being_dragged != null:
		Flow.item_being_dragged._on_gui_input(event)
		return

	if event.is_action_pressed("left_mouse_button"):
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
		else:
			emit_signal("nav_path_requested")

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return

	if area is class_car:
		position = respawn_position
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	if area.get_parent() is class_character:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()
	if area is class_item:
		#respawn_position = position
		print("Player entered the item!")
		_overlapping_item = area
	if area is class_gummy:
		is_in_gummy = true
		print("Player entered gummy!")

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return

	if area is class_car:
		pass
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
	return move_speed

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_state : int = player_state
	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			player_state = STATE.RIGHT
		elif normalized_direction.x < 0:
			player_state = STATE.LEFT
		else:
			player_state = STATE.DEFAULT
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			player_state = STATE.DOWN
		elif normalized_direction.y < 0:
			player_state = STATE.UP
		else:
			player_state = STATE.DEFAULT
	else:
		player_state = STATE.DEFAULT

	if old_state != player_state:
		update_animation()

func update_animation():
	var state_settings : Dictionary = state_machine.get(player_state, {})
	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

var state_machine := {
	STATE.LEFT:{
		"animation_name": "move_right",
		"flip_h": true
	},
	STATE.RIGHT:{
		"animation_name": "move_right"
	},
	STATE.UP:{
		"animation_name": "move_up"
	},
	STATE.DOWN:{
		"animation_name": "move_down"
	},
	STATE.DEFAULT:{
		"animation_name": "default"
	}
}
