extends Control
class_name class_inventory_item

onready var _sprite = $Sprite

var _is_being_dragged := false
var mouse_offset := Vector2.ZERO

func _ready():
	var _error := connect("mouse_entered", self, "_on_mouse_entered")
	_error = connect("mouse_exited", self, "_on_mouse_exited")
	_error = connect("gui_input", self, "_on_gui_input")

func _on_mouse_entered():
	print("MOUSE ENTERED INVENTORY ITEM")

func _on_mouse_exited():
	print("MOUSE EXITED INVENTORY ITEM")

func _on_gui_input(event):
	if _is_being_dragged:
		if event.is_action_pressed("left_mouse_button") or event.is_action_pressed("right_mouse_button"):
			_is_being_dragged = false
			Flow.item_being_dragged = null
	elif event.is_action_pressed("left_mouse_button") :
		_is_being_dragged = true
		Flow.item_being_dragged = self
		mouse_offset = get_local_mouse_position()
		set_process(true)

func _process(delta):
	if _is_being_dragged:
		_sprite.position = get_local_mouse_position() - mouse_offset
	else:
		_sprite.position = Vector2.ZERO
		set_process(false)
