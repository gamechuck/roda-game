extends Area2D
class_name class_car

var initial_pos := Vector2(0, 0)
var final_pos := Vector2(0, 0)

var waiting_for_reset := false
var is_in_panic_mode := false

onready var _animated_sprite := $AnimatedSprite
onready var _collision_shape_2D := $CollisionShape2D

func _ready():
	position = final_pos
	waiting_for_reset = true

func init_car(type : String):
	var car_settings : Dictionary = car_types.get(type, "left")
	_animated_sprite.play(car_settings.get("animation_name", "left_right"))
	_animated_sprite.flip_h = car_settings.get("flip_h", false)
	_animated_sprite.flip_v = car_settings.get("flip_v", false)
	
	_collision_shape_2D.rotation_degrees = car_settings.get("rotation_degrees", 0)

func _physics_process(_delta):
	if not waiting_for_reset:
		var move_direction := position.direction_to(final_pos)
		_move(move_direction)

		if position.distance_to(final_pos) < Flow.CAR_MOVE_SPEED:
			waiting_for_reset = true

func _move(move_direction : Vector2):
	if is_in_panic_mode:
		move_direction *= Flow.PANIC_MODIFIER
	position += Flow.CAR_MOVE_SPEED*move_direction

func reset():
	position = initial_pos
	waiting_for_reset = false

var car_types := {
	"left":{
		"animation_name": "left_right",
		"flip_h": true
	},
	"right":{
		"animation_name": "left_right"
	},
	"up":{
		"animation_name": "up",
		"flip_v": true,
		"rotation_degrees": 90
	},
	"down":{
		"animation_name": "down",
		"rotation_degrees": 90
	}
}
