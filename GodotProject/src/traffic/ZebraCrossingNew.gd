tool
extends Area2D
class_name class_zebra_crossing_new

export var extents := Vector2.ZERO setget set_extents

var player_is_inside := false

signal player_exited_zebra

func _ready():

	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	if not Engine.editor_hint:
		var _success := connect("area_shape_entered", self, "_on_area_shape_entered")
		_success = connect("area_shape_exited", self, "_on_area_shape_exited")

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.get_parent() is class_player:
		player_is_inside = true

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	if area.get_parent() is class_player:
		player_is_inside = false
		emit_signal("player_exited_zebra")
