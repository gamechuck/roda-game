extends TextureRect
class_name class_character_slot

var pressed := false setget set_pressed, get_pressed
func set_pressed(value : bool):
	pressed = value
	_texture_button.pressed = value
func get_pressed() -> bool:
	return pressed

var disabled := false setget set_disabled, get_disabled
func set_disabled(value : bool):
	disabled = value
	_texture_button.disabled = value
func get_disabled() -> bool:
	return disabled

var texture_normal : Texture setget , get_texture_normal
func get_texture_normal() -> Texture:
	return _texture_button.texture_normal

onready var _texture_button := $TextureButton

signal button_pressed(pressed)

func _ready():
	var _error : int = _texture_button.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	pressed = _texture_button.pressed
	emit_signal("button_pressed", pressed)
