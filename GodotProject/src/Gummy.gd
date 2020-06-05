tool
extends Area2D
class_name class_gummy

onready var _collision_shape_2D := $CollisionShape2D

export var extents := Vector2.ZERO setget set_extents

func _ready():

	var shape := RectangleShape2D.new()
	shape.extents = extents
	$CollisionShape2D.shape = shape

func set_extents(value : Vector2):
	extents = value
	var shape : RectangleShape2D = $CollisionShape2D.shape
	shape.extents = extents

