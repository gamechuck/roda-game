tool
extends Area2D
class_name class_zebra_crossing

onready var _timer := $Timer
onready var _traffic_lights_container := $Lights

export var extents := Vector2.ZERO setget set_extents
export var light_color : int = Flow.LIGHT_COLOR.RED setget set_light_color

var player_is_inside := false
var has_traffic_lights := false

signal movement_is_allowed

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

func set_light_color(value : int):
	light_color = value
	update_lights()

func _ready():
	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	update_lights()

	if not Engine.editor_hint:
		if not has_traffic_lights:
			var _success := connect("area_shape_entered", self, "_on_area_shape_entered")
			_success = connect("area_shape_exited", self, "_on_area_shape_exited")
		else:
			var _error := _timer.connect("timeout", self, "_on_timer_timeout")
			_timer.wait_time = get_wait_time()
			_timer.one_shot = true
			_timer.start()

func update_lights():
	for traffic_light in $Lights.get_children():
		if traffic_light is class_traffic_light:
			has_traffic_lights = true
			traffic_light.light_color = light_color

func _on_timer_timeout():
	light_color = get_next_color()

	if light_color == Flow.LIGHT_COLOR.RED:
		emit_signal("movement_is_allowed")

	_timer.wait_time = get_wait_time()
	_timer.start()
	update_lights()

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.get_parent().name == "Player":
		player_is_inside = true

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if area.get_parent().name == "Player":
		player_is_inside = false
		emit_signal("movement_is_allowed")

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
