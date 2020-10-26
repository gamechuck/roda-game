tool
extends YSort

const tile_width := 32.0*Vector2.ONE
const tile_offset := 32.0*Vector2.ONE

onready var _cars_container := $Cars

onready var _path_follow_resource := preload("res://src/game/base/PathFollow.tscn")
onready var _car_resource := preload("res://src/game/traffic/Car.tscn")
onready var _path_2D := $Path2D

export(int) var amount_of_cars := 0
export(bool) var is_clockwise := true

export var points := PoolVector2Array() setget set_points
func set_points(value : PoolVector2Array):
	points = value

	var curve : Curve2D = $Path2D.curve
	curve.clear_points()
	for index in points.size():
		# Snap & offset the point!
		points[index] -= tile_offset
		points[index] = (points[index]/tile_width).round()*tile_width
		points[index] += tile_offset
		curve.add_point(points[index], Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)

	update()

func _ready():
	randomize()

	var curve := Curve2D.new()

	if Geometry.is_polygon_clockwise(points) and not is_clockwise:
		points.invert()
	elif not Geometry.is_polygon_clockwise(points) and is_clockwise:
		points.invert()

	for point in points:
		curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)
	_path_2D.curve = curve

	if not Engine.editor_hint:
		for car in _cars_container.get_children():
			_cars_container.remove_child(car)
			car.queue_free()
		for path_follow in _path_2D.get_children():
			_path_2D.remove_child(path_follow)
			path_follow.queue_free()

		if amount_of_cars > 0:
			var offset_increment : float = 1.0/amount_of_cars
			var next_car : classCar = null
			var first_car : classCar = null
			for _i in range(amount_of_cars, 0, -1):
				var car : classCar = spawn_car(_i*offset_increment)
				if next_car == null:
					first_car = car
				else:
					car.next_car = next_car
				next_car = car
			# Set the first car's next car to the last car!
			first_car.next_car = next_car

func spawn_car(initial_offset : float) -> classCar:
	var path_follow : PathFollow2D = _path_follow_resource.instance()
	$Path2D.add_child(path_follow)

	var car : classCar = _car_resource.instance()
	car.initial_offset = initial_offset
	car.path_follow = path_follow
	_cars_container.add_child(car)
	car.owner = self

	path_follow.get_node("RemoteTransform2D").remote_path = car.get_path()
	return car
