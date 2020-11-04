tool
extends YSort
class_name classZebraCrossing

onready var _timer := $Timer
onready var _traffic_lights_container := $Lights
onready var _interact_area := $InteractArea

export var extents := Vector2.ZERO setget set_extents
export var light_color : int = ConfigData.LIGHT_COLOR.RED setget set_light_color

var player_is_inside := false
var has_traffic_lights := false

signal movement_is_allowed

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $InteractArea/CollisionShape2D.shape
	shape.extents = extents

func set_light_color(value : int):
	light_color = value
	update_lights()

func _ready():
	var shape := RectangleShape2D.new()
	shape.extents = extents
	$InteractArea/CollisionShape2D.shape = shape

	update_lights()

	if not Engine.editor_hint:
		var _success := _interact_area.connect("body_entered", self, "_on_body_entered")
		_success = _interact_area.connect("body_exited", self, "_on_body_exited")

		if has_traffic_lights:
			var _error := _timer.connect("timeout", self, "_on_timer_timeout")
			_timer.wait_time = get_wait_time()
			_timer.one_shot = true
			_timer.start()

	update()

func update_lights():
	for light in $Lights.get_children():
		has_traffic_lights = true
		if light is classTrafficLight:
			light.light_color = get_opposite_color()
		if light is classPedestrianLight:
			light.light_color = light_color

func _on_timer_timeout():
	light_color = get_next_color()

	if light_color == ConfigData.LIGHT_COLOR.RED:
		emit_signal("movement_is_allowed")

	_timer.wait_time = get_wait_time()
	_timer.start()
	update_lights()

func _on_body_entered(body : PhysicsBody2D):
	if body.name == "Player":
		if not has_traffic_lights and body.get_state_property("entered_zebra") == 0:
			body.set_state_property("entered_zebra", 1)
			Director.start_knot_dialogue(body, "conv_first_time_zebra")
		elif has_traffic_lights and body.get_state_property("entered_traffic_lights") == 0 :
			body.set_state_property("entered_traffic_lights", 1)
			Director.start_knot_dialogue(body, "conv_first_time_traffic_lights")
		player_is_inside = true

func _on_body_exited(body : PhysicsBody2D):
	if body.name == "Player":
		player_is_inside = false
		if not has_traffic_lights:
			emit_signal("movement_is_allowed")

func get_wait_time() -> float:
	match light_color:
		ConfigData.LIGHT_COLOR.RED:
			return ConfigData.TRAFFIC_RED_TIME
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED:
			return ConfigData.TRAFFIC_YELLOW_AFTER_RED_TIME
		ConfigData.LIGHT_COLOR.GREEN:
			return ConfigData.TRAFFIC_GREEN_TIME
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			return ConfigData.TRAFFIC_YELLOW_AFTER_GREEN_TIME
		_:
			return 0.0

func get_next_color() -> int:
	match light_color:
		ConfigData.LIGHT_COLOR.RED:
			return ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED:
			return ConfigData.LIGHT_COLOR.GREEN
		ConfigData.LIGHT_COLOR.GREEN:
			return ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			return ConfigData.LIGHT_COLOR.RED
		_:
			return 0

func get_opposite_color() -> int:
	match light_color:
		ConfigData.LIGHT_COLOR.RED:
			return ConfigData.LIGHT_COLOR.GREEN
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED:
			return ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN
		ConfigData.LIGHT_COLOR.GREEN:
			return ConfigData.LIGHT_COLOR.RED
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			return ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED
		_:
			return 0
