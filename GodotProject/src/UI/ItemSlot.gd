extends PanelContainer
class_name class_item_slot

var is_empty := true
var item_id := "Bush"

var _is_being_dragged := false
var _mouse_offset := Vector2.ZERO

onready var _sprite = $Sprite

func fill_with_item(id : String):
	item_id = id
	is_empty = false
	pass

func _gui_input(event):
	if _is_being_dragged:
		if event.is_action_released("left_mouse_button"):
			_is_being_dragged = false
			#Flow.item_being_dragged = null
	elif event.is_action_pressed("left_mouse_button"):
		_is_being_dragged = true
		Flow.item_being_dragged = self
		_mouse_offset = get_local_mouse_position()
		set_process(true)

func _process(_delta):
	if _is_being_dragged:
		_sprite.position = get_local_mouse_position() - _mouse_offset
	else:
		_sprite.position = Vector2.ZERO
		set_process(false)
