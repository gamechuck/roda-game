extends Area2D
class_name class_item

onready var _collision_shape_2D := $CollisionShape2D

export var id : String

func _input(event):
	var extents : Vector2 = _collision_shape_2D.shape.extents
	var rect : Rect2 = Rect2(position - extents, 2*extents)
	if rect.has_point(get_global_mouse_position()):
		if event.is_action_pressed("left_mouse_button"):
			Flow.active_item = self
