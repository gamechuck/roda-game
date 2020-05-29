tool
extends Area2D
class_name class_street

onready var _car_resource := preload("res://src/Car.tscn")
onready var _cars_container := $Cars
onready var _timer := $Timer
onready var _collision_shape_2D := $CollisionShape2D

const MAX_AMOUNT_OF_CARS := 10
const MINIMUM_TIME_BETWEEN_CARS := 0.75

export var extents := Vector2.ZERO setget set_extents
export(String, "left", "right") var direction

func _ready():
	
	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	if not Engine.editor_hint:
		for car in _cars_container.get_children():
			_cars_container.remove_child(car)
			car.queue_free()

		for _i in range(0, MAX_AMOUNT_OF_CARS):
			spawn_car()
	
		var _success := _timer.connect("timeout", self, "_on_timer_timeout")
		_timer.one_shot = true
		_timer.wait_time = 1
		_timer.start()

func spawn_car():
	var car := _car_resource.instance()

	match direction:
		"left":
			car.initial_pos.x = -extents.x
			car.final_pos.x = extents.x
		"right":
			car.initial_pos.x = extents.x
			car.final_pos.x = -extents.x
	_cars_container.add_child(car)

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

func _on_timer_timeout():
	for car in _cars_container.get_children():
		if car.waiting_for_reset:
			car.reset()
			break
	_timer.wait_time = randf() + MINIMUM_TIME_BETWEEN_CARS
	_timer.start()
