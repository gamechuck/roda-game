extends KinematicBody2D
class_name class_player

const MOVE_SPEED := 2.0

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []
var is_in_dialogue := false

var _overlapping_character : class_character = null

onready var _interact_area := $InteractArea

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

		move_and_slide(move_direction*MOVE_SPEED/_delta)

		#_move(move_direction.normalized())
#		for i in get_slide_count():
#			var collision = get_slide_collision(i)
#			print("I collided with ", collision.collider.name)
#
#		if nav_path.size() > 0:
#			var distance := position.distance_to(nav_path[0])
#			if distance > MOVE_SPEED:
#				var new_position := position.linear_interpolate(nav_path[0], MOVE_SPEED/distance)
#				position = new_position
#			else:
#				nav_path.remove(0)

func _input(event):
	if event.is_action_pressed("interact"):
		if is_in_dialogue:
			is_in_dialogue = Flow.dialogue_UI.update_dialogue()
		elif _overlapping_character != null:
			Flow.dialogue_UI.start_dialogue(_overlapping_character)
			is_in_dialogue = true

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area is class_street:
		#respawn_position = position
		print("Player entered the street!")
	if area is class_car:
		position = respawn_position
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	if area.get_parent() is class_character:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if area.get_parent() is class_character:
		print("Player exited a character's interact area!")
		if _overlapping_character == area.get_parent():
			_overlapping_character = null
