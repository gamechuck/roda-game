extends KinematicBody2D
class_name class_player

enum STATE {DEFAULT, LEFT, RIGHT, UP, DOWN}

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []
var is_in_dialogue := false

var _overlapping_character : class_character = null
var _overlapping_street : class_street = null
var _overlapping_zebra_crossing : class_zebra_crossing = null
var _overlapping_item : class_item = null

onready var _interact_area := $InteractArea
onready var _animated_sprite := $AnimatedSprite

func _ready():
	var _success := _interact_area.connect("area_shape_entered", self, "_on_area_shape_entered")
	_success = _interact_area.connect("area_shape_exited", self, "_on_area_shape_exited")

func _physics_process(_delta):
	if not Flow.is_in_editor_mode:
		var move_direction := Vector2.ZERO
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
				var new_position := position.linear_interpolate(nav_path[0], Flow.PLAYER_MOVE_SPEED/distance)
				move_direction = new_position - position
			else:
				nav_path.remove(0)

		var normalized_direction := move_direction.normalized()
		var abs_direction := normalized_direction.abs()
		if abs_direction.x > abs_direction.y:
			if normalized_direction.x > 0:
				set_animation("right")
			elif normalized_direction.x < 0:
				set_animation("left")
			else:
				set_animation("idle")
		elif abs_direction.y > abs_direction.x:
			if normalized_direction.y > 0:
				set_animation("down")
			elif normalized_direction.y < 0:
				set_animation("up")
			else:
				set_animation("idle")
		else:
			set_animation("idle")

		var _linear_velocity := move_and_slide(normalized_direction*Flow.PLAYER_MOVE_SPEED/_delta)

#		for i in get_slide_count():
#			var collision = get_slide_collision(i)
#			print("I collided with ", collision.collider.name)

func set_animation(state_name : String):
	var state_settings : Dictionary = state_machine.get(state_name, {})
	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

func _input(event):
	if event.is_action_pressed("interact"):
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
		elif _overlapping_character != null:
			is_in_dialogue = Flow.dialogue_UI.start_dialogue(_overlapping_character)
		elif _overlapping_item != null:
			_overlapping_item.queue_free()
			_overlapping_item = null
	if event.is_action_pressed("toggle_inventory"):
		Flow.inventory_UI.visible = not Flow.inventory_UI.visible

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return

	if area is class_street:
		#respawn_position = position
		print("Player entered the street!")
		_overlapping_street = area
		_check_panic_condition()
	if area is class_car:
		position = respawn_position
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	if area is class_zebra_crossing:
		print("Player entered the zebra crossing!")
		_overlapping_zebra_crossing = area
	if area.get_parent() is class_character:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()
	if area is class_item:
		#respawn_position = position
		print("Player entered the item!")
		_overlapping_item = area

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if not is_instance_valid(area) or area == null:
		return

	if area is class_street:
		print("Player exited the street!")
		if _overlapping_street == area:
			_overlapping_street = null
		area.is_in_panic_mode = false
	if area is class_car:
		pass
	if area is class_zebra_crossing:
		print("Player exited the zebra crossing!")
		_check_panic_condition()
		if _overlapping_zebra_crossing == area:
			_overlapping_zebra_crossing = null
			_check_panic_condition()
	if area.get_parent() is class_character:
		print("Player exited a character's interact area!")
		if _overlapping_character == area.get_parent():
			_overlapping_character = null
	if area is class_item:
		#respawn_position = position
		print("Player exited the item!")
		if _overlapping_item == area:
			_overlapping_item = null

func _check_panic_condition() -> void:
	if _overlapping_street != null:
		var panic_condition : bool = _overlapping_street.light_color != Flow.LIGHT_COLOR.GREEN
		panic_condition = panic_condition or _overlapping_zebra_crossing == null
		if panic_condition:
			_overlapping_street.is_in_panic_mode = true
		else:
			_overlapping_street.is_in_panic_mode = false

var state_machine := {
	"left":{
		"animation_name": "move_right",
		"flip_h": true
	},
	"right":{
		"animation_name": "move_right"
	},
	"up":{
		"animation_name": "move_up"
	},
	"down":{
		"animation_name": "move_down"
	},
	"idle":{
		"animation_name": "default"
	}
}
