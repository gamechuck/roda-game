extends Area2D
class_name class_car

const MOVE_SPEED := 4.0

var initial_pos := Vector2(-200, 0)
var final_pos := Vector2(200, 0)

var waiting_for_reset := false

onready var _sprite := $Sprite

func _ready():
	position = final_pos
	waiting_for_reset = true

func _physics_process(_delta):
	if not waiting_for_reset:
		var move_direction := position.direction_to(final_pos)
		_move(move_direction)

		if position.distance_to(final_pos) < MOVE_SPEED:
			waiting_for_reset = true

func _move(move_direction : Vector2):
	if move_direction.x < 0:
		_sprite.flip_h = false
	else:
		_sprite.flip_h = true
	position += MOVE_SPEED*move_direction

func reset():
	position = initial_pos
	waiting_for_reset = false
