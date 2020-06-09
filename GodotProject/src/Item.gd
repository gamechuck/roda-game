extends Area2D
class_name class_item

onready var _collision_shape_2D := $CollisionShape2D

func _input(event):
	var extents : Vector2 = _collision_shape_2D.shape.extents
	var rect : Rect2 = Rect2(position - extents, 2*extents)
	if rect.has_point(get_global_mouse_position()):
		if event.is_action_pressed("left_mouse_button"):
			Flow.active_item = self
		elif event.is_action_released("left_mouse_button"):
			if Flow.item_being_dragged != null:
				var item_slot : class_item_slot = Flow.item_being_dragged
				var item_id = item_slot.item_id
				Flow.player.is_in_dialogue = \
					Flow.dialogue_UI.start_use_item_dialogue(self, item_id)
				Flow.item_being_dragged = null
