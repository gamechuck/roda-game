tool
extends YSort

onready var _car_resource := preload("res://src/traffic/Car.tscn")
onready var _path_2D := $Path2D

export var amount_of_cars := 0 setget set_amount_of_cars
export var points := PoolVector2Array() setget set_points

func set_amount_of_cars(value : int):
	amount_of_cars = value
	if Engine.editor_hint:
		_ready()

func set_points(value : PoolVector2Array):
	points = value
	var curve : Curve2D = $Path2D.curve
	curve.clear_points()
	for point in points:
		curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)

	update()

func _ready():
	randomize()

	var curve := Curve2D.new()
	for point in points:
		curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)
	_path_2D.curve = curve

	if not Engine.editor_hint:
		for car in _path_2D.get_children():
			_path_2D.remove_child(car)
			car.queue_free()

		if amount_of_cars > 0:
			var offset_increment : float = 1.0/amount_of_cars
			for _i in range(0, amount_of_cars):
				spawn_car(_i*offset_increment)

func spawn_car(initial_offset : float):
	var car := _car_resource.instance()
	car.initial_offset = initial_offset
	car.traffic_loop = self
	$Path2D.add_child(car)
	car.owner = self
