extends Node2D

onready var _traffic_lights_container := $TrafficLights
onready var _streets_container := $Streets
onready var _zebra_crossings_container := $ZebraCrossings

onready var _timer := $Timer

export var light_color : int = Flow.LIGHT_COLOR.RED

var is_player_in_street := false setget set_is_player_in_street
var is_player_in_zebra_crossing := false setget set_is_player_in_zebra_crossing
var _is_in_panic_mode := false

func _ready():

	print(Flow.TRAFFIC_RED_TIME)

	for street in _streets_container.get_children():
		if street is class_street:
			street.connect("player_is_inside_area", self, "set_is_player_in_street")

	for zebra_crossing in _zebra_crossings_container.get_children():
		if zebra_crossing is class_zebra_crossing:
			zebra_crossing.connect("player_is_inside_area", self, "set_is_player_in_zebra_crossing")

	update_traffic()

	var _error := _timer.connect("timeout", self, "_on_timer_timeout")
	_timer.wait_time = get_wait_time()
	_timer.one_shot = true
	_timer.start()

func update_traffic():
	for traffic_light in _traffic_lights_container.get_children():
		if traffic_light is class_traffic_light:
			traffic_light.light_color = light_color

	for street in _streets_container.get_children():
		if street is class_street:
			street.light_color = light_color

	_check_panic_condition()

func _on_timer_timeout():
	light_color = get_next_color()
	
	_timer.wait_time = get_wait_time()
	_timer.start()
	update_traffic()

func _check_panic_condition() -> void:
	if is_player_in_street:
		match light_color:
			Flow.LIGHT_COLOR.GREEN, Flow.LIGHT_COLOR.YELLOW_AFTER_GREEN:
				if is_player_in_zebra_crossing:
					_is_in_panic_mode = false
				else:
					_is_in_panic_mode = true
			_:
				_is_in_panic_mode = true
	else:
		_is_in_panic_mode = false
	
	for street in _streets_container.get_children():
		if street is class_street:
			street.is_in_panic_mode = _is_in_panic_mode

func set_is_player_in_street(value : bool):
	is_player_in_street = value
	if is_player_in_street:
		print("Player entered the street.")
	else:
		print("Player exited the street.")
	_check_panic_condition()

func set_is_player_in_zebra_crossing(value : bool):
	is_player_in_zebra_crossing = value
	if is_player_in_zebra_crossing:
		print("Player entered the zebra crossing.")
	else:
		print("Player exited the zebra crossing.")
	_check_panic_condition()

func get_wait_time() -> float:
	match light_color:
		Flow.LIGHT_COLOR.RED:
			return Flow.TRAFFIC_RED_TIME
		Flow.LIGHT_COLOR.YELLOW_AFTER_RED:
			return Flow.TRAFFIC_YELLOW_AFTER_RED_TIME
		Flow.LIGHT_COLOR.GREEN:
			return Flow.TRAFFIC_GREEN_TIME
		Flow.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			return Flow.TRAFFIC_YELLOW_AFTER_GREEN_TIME
		_:
			return 0.0

func get_next_color() -> int:
	match light_color:
		Flow.LIGHT_COLOR.RED:
			return Flow.LIGHT_COLOR.YELLOW_AFTER_RED
		Flow.LIGHT_COLOR.YELLOW_AFTER_RED:
			return Flow.LIGHT_COLOR.GREEN
		Flow.LIGHT_COLOR.GREEN:
			return Flow.LIGHT_COLOR.YELLOW_AFTER_GREEN
		Flow.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			return Flow.LIGHT_COLOR.RED
		_:
			return 0
