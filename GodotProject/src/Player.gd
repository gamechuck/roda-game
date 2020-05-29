extends Area2D
class_name class_player

const MOVE_SPEED := 2.0

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []

func _ready():
	var _success := connect("area_shape_entered", self, "_on_area_shape_entered")

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

		_move(move_direction.normalized())

		if nav_path.size() > 0:
			var distance := position.distance_to(nav_path[0])
			if distance > MOVE_SPEED:
				var new_position := position.linear_interpolate(nav_path[0], MOVE_SPEED/distance)
				position = new_position
			else:
				nav_path.remove(0)

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area is class_street:
		#respawn_position = position
		print("Player entered the street!")
	if area is class_car:
		position = respawn_position
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")

func _move(move_direction : Vector2):
	position += move_direction*MOVE_SPEED
