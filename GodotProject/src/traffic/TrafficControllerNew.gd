extends YSort

onready var _car_resource := preload("res://src/traffic/CarNew.tscn")
onready var _path_2D := $Path2D

func _ready():
	for car in _path_2D.get_children():
		_path_2D.remove_child(car)
		car.queue_free()

	var offset_increment : float = 1.0/Flow.MAX_AMOUNT_OF_CARS
	for _i in range(0, Flow.MAX_AMOUNT_OF_CARS):
		spawn_car(_i*offset_increment)

func spawn_car(initial_offset : float):
	var car := _car_resource.instance()
	car.initial_offset = initial_offset
	car.curve_length = _path_2D.curve.get_baked_length()
	_path_2D.add_child(car)
