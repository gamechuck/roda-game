tool
extends Control
class_name class_character_slot

enum CHARACTER {BABY, CHILD, TEENAGER, ADULT}
export(CHARACTER) var type := CHARACTER.ADULT

var pressed := false setget set_pressed, get_pressed
func set_pressed(value : bool):
	pressed = value
	$TextureButton.pressed = value
func get_pressed() -> bool:
	return pressed

var disabled := false setget set_disabled, get_disabled
func set_disabled(value : bool):
	disabled = value
	$TextureButton.disabled = value
func get_disabled() -> bool:
	return disabled

export var texture_normal : Texture setget set_texture_normal, get_texture_normal
func set_texture_normal(value : Texture) -> void:
	$TextureButton.texture_normal = value
func get_texture_normal() -> Texture:
	return $TextureButton.texture_normal

export var texture_pressed : Texture setget set_texture_pressed, get_texture_pressed
func set_texture_pressed(value : Texture) -> void:
	$TextureButton.texture_pressed = value
func get_texture_pressed() -> Texture:
	return $TextureButton.texture_pressed

export var texture_disabled : Texture setget set_texture_disabled, get_texture_disabled
func set_texture_disabled(value : Texture) -> void:
	$TextureButton.texture_disabled = value
func get_texture_disabled() -> Texture:
	return $TextureButton.texture_disabled

signal button_pressed(pressed)

func _ready():
	if not Engine.editor_hint:
		var _error : int = $TextureButton.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	pressed = $TextureButton.pressed
	emit_signal("button_pressed", pressed)
