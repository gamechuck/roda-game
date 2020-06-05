tool
extends Area2D
class_name class_street

onready var _car_resource := preload("res://src/traffic/Car.tscn")
onready var _cars_container := $Cars
onready var _timer := $Timer
onready var _collision_shape_2D := $CollisionShape2D

var is_in_panic_mode := false setget set_is_in_panic_mode
var light_color : int = Flow.LIGHT_COLOR.RED setget set_light_color

export var extents := Vector2.ZERO setget set_extents
export(String, "left", "right", "up", "down") var direction

signal player_is_inside_area(is_inside)

func _ready():

	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	if not Engine.editor_hint:
		var _success := connect("area_shape_entered", self, "_on_area_shape_entered")
		_success = connect("area_shape_exited", self, "_on_area_shape_exited")

		for car in _cars_container.get_children():
			_cars_container.remove_child(car)
			car.queue_free()

		for _i in range(0, Flow.MAX_AMOUNT_OF_CARS):
			spawn_car()
	
		_success = _timer.connect("timeout", self, "_on_reset_timer_timeout")
		_timer.one_shot = true
		_timer.wait_time = 0.1
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
		"up":
			car.initial_pos.y = extents.y
			car.final_pos.y = -extents.y
		"down":
			car.initial_pos.y = -extents.y
			car.final_pos.y = extents.y
	_cars_container.add_child(car)

	car.init_car(direction)

func set_is_in_panic_mode(value : bool):
	if Engine.editor_hint:
		return

	if is_in_panic_mode != value and _timer.is_inside_tree():
		if value:
			_timer.start(_timer.time_left/Flow.PANIC_MODIFIER)
		else:
			_timer.start(_timer.time_left*Flow.PANIC_MODIFIER)

	is_in_panic_mode = value
	for car in _cars_container.get_children():
		car.is_in_panic_mode = value

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

func set_light_color(value : int):
	light_color = value

func reset_car() -> void:
	for car in _cars_container.get_children():
		if car.waiting_for_reset:
			car.reset()
			break

func reset_timer() -> void:
	var random_wait_time := randf()
	random_wait_time *= (Flow.MAXIMUM_TIME_BETWEEN_CARS-Flow.MINIMUM_TIME_BETWEEN_CARS)
	random_wait_time += Flow.MINIMUM_TIME_BETWEEN_CARS
	if is_in_panic_mode:
		random_wait_time /= Flow.PANIC_MODIFIER
	_timer.wait_time = random_wait_time
	_timer.start()

func _on_reset_timer_timeout():
	match light_color:
		Flow.LIGHT_COLOR.RED:
			reset_car()
		_:
			if is_in_panic_mode:
				reset_car()
	reset_timer()

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.get_parent() is class_player:
		emit_signal("player_is_inside_area", true)
		
func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if area.get_parent() is class_player:
		emit_signal("player_is_inside_area", false)