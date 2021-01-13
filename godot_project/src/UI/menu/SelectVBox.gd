tool
class_name classSelectVBox
extends VBoxContainer

signal start_button_pressed

export var number := 1 setget set_number
func set_number(value : int) -> void:
	number = value
	if is_inside_tree():
		update_select_vbox()

export var description := "" setget set_description
func set_description(value : String) -> void:
	description = value
	if is_inside_tree():
		update_select_vbox()

export var texture : Texture setget set_texture
func set_texture(value : Texture) -> void:
	texture = value
	if is_inside_tree():
		update_select_vbox()

func _ready():
	update_select_vbox()

	if not Engine.editor_hint:
		var _error := $StartButton.connect("pressed", self, "_on_start_button_pressed")

func update_select_vbox():
	$HB/Label.text = "Level {0}".format([number])
	$PC/MC/VB/DescriptionLabel.text = description

	$PC/MC/VB/TextureRect.texture = texture

func _on_start_button_pressed():
	emit_signal("start_button_pressed")
