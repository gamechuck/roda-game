extends Path2D

onready var SCENE_PATH_FOLLOW := preload("res://src/game/base/PathFollow.tscn")
onready var SCENE_CAR := preload("res://src/game/traffic/Car.tscn")

export(int) var amount_of_cars := 0
export(bool) var is_clockwise := true

var cars : Node2D

func _ready():
	randomize()

	cars = get_node("../../Sorted/Cars")
	for child in cars.get_children():
		cars.remove_child(child)
		child.queue_free()

	for child in get_children():
		remove_child(child)
		child.queue_free()

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
	var path_follow : PathFollow2D = SCENE_PATH_FOLLOW.instance()
	add_child(path_follow)

	var car : classCar = SCENE_CAR.instance()
	car.initial_offset = initial_offset
	car.path_follow = path_follow
	cars.add_child(car)

	path_follow.get_node("RemoteTransform2D").remote_path = car.get_path()
	return car
