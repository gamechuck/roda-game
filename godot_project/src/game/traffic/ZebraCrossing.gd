tool
extends Area2D
class_name classZebraCrossing

export(Vector2) var extents := Vector2.ZERO setget set_extents
func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

export var light_color : int = ConfigData.LIGHT_COLOR.RED

var player_is_inside := false
var has_traffic_lights := false

var lights : YSort

signal movement_is_allowed

func _ready():
	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	if not Engine.editor_hint:
		var _success := connect("body_entered", self, "_on_body_entered")
		_success = connect("body_exited", self, "_on_body_exited")

		if has_node("../../Sorted/Lights/" + name):
			lights = get_node("../../Sorted/Lights/" + name)
			has_traffic_lights = true

			var _error := $Timer.connect("timeout", self, "_on_timer_timeout")
			$Timer.wait_time = get_wait_time()
			$Timer.one_shot = true
			$Timer.start()

			update_lights()
		else:
			has_traffic_lights = false

	update()

func update_lights():
	for light in lights.get_children():
		has_traffic_lights = true
		if light is classTrafficLight:
			light.light_color = get_opposite_color()
		if light is classPedestrianLight:
			light.light_color = light_color

func _on_timer_timeout():
	light_color = get_next_color()

	if light_color == ConfigData.LIGHT_COLOR.RED:
		emit_signal("movement_is_allowed")

	$Timer.wait_time = get_wait_time()
	$Timer.start()
	update_lights()

func _on_body_entered(body : PhysicsBody2D):
	# Use the body's name instead of the class due to circular referencing!
	if body.name == "Player":
		if not has_traffic_lights and body.local_variables.get("player_entered_zebra", 0) == 0:
			Director.start_knot_dialogue(body, "conv_first_time_zebra")
		elif has_traffic_lights and body.local_variables.get("player_entered_traffic_lights", 0) == 0:
			Director.start_knot_dialogue(body, "conv_first_time_traffic_lights")
		player_is_inside = true

func _on_body_exited(body : PhysicsBody2D):
	# Use the body's name instead of the class due to circular referencing!
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
