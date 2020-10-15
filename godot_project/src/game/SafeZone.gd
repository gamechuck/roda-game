tool
extends Area2D
class_name class_safe_zone

export var extents := Vector2.ZERO setget set_extents

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

func _ready():
	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

	update()
