extends Node2D

onready var _traffic_lights_container := $TrafficLights
onready var _streets_container := $Streets
onready var _zebra_crossings_container := $ZebraCrossings

onready var _timer := $Timer

var light_color : int = Flow.LIGHT_COLOR.RED
var previous_is_red = true

func _ready():
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

func _on_timer_timeout():
	light_color = get_next_color()
	
	_timer.wait_time = get_wait_time()
	_timer.start()
	update_traffic()

func get_wait_time() -> float:
	match light_color:
		Flow.LIGHT_COLOR.RED:
			return Flow.TRAFFIC_RED_TIME
		Flow.LIGHT_COLOR.YELLOW:
			return Flow.TRAFFIC_YELLOW_TIME
		Flow.LIGHT_COLOR.GREEN:
			return Flow.TRAFFIC_GREEN_TIME
		_:
			return 0.0

func get_next_color() -> int:
	match light_color:
		Flow.LIGHT_COLOR.RED:
			previous_is_red = true
			return Flow.LIGHT_COLOR.YELLOW
		Flow.LIGHT_COLOR.YELLOW:
			if previous_is_red:
				return Flow.LIGHT_COLOR.GREEN
			else:
				return Flow.LIGHT_COLOR.RED
		Flow.LIGHT_COLOR.GREEN:
			previous_is_red = false
			return Flow.LIGHT_COLOR.YELLOW
		_:
			return 0
