extends Reference
class_name class_inventory_item

signal pressed

var id = ""
var amount := 0
var pressed : bool setget set_pressed, get_pressed
func set_pressed(value : bool):
	_pressed = value
	emit_signal("pressed", _pressed)
func get_pressed() -> bool:
	return _pressed

var _pressed := false
