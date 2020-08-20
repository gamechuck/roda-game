extends Area2D
class_name class_item

onready var _collision_shape_2D := $CollisionShape2D

export(String) var id : String

func _ready():
	add_to_group("items")

	set_visible()

func _exit_tree():
	if is_inside_tree() and get_tree().has_group("items"):
		remove_from_group("items")

func set_visible(value : bool = visible):
	visible = value
	if visible:
		print("Enabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = false
	else:
		print("Disabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = true

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var extents : Vector2 = _collision_shape_2D.shape.extents
		var rect : Rect2 = Rect2(position - extents, 2*extents)
		if rect.has_point(get_global_mouse_position()):
			Flow.active_item = self
		# This is a bit filthy, but it does the job!
		# Otherwise new mouse clicks might still contain the 
		# now obsolete active_item!
		elif Flow.active_item == self:
			Flow.active_item = null
