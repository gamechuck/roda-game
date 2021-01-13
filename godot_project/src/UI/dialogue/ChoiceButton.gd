tool
extends Button

const FONT_4 := preload("res://assets/fonts/dynamic/luckiest_guy_size4.tres")
const FONT_6 := preload("res://assets/fonts/dynamic/luckiest_guy_size6.tres")
const FONT_8 := preload("res://assets/fonts/dynamic/luckiest_guy_size8.tres")

signal choice_button_pressed

export var _text : String setget set_text
func set_text(value : String):
	_text = value
	if is_inside_tree():
		_update_text()

func _ready():
	if not Engine.editor_hint:
		var _error := connect("pressed", self, "_on_choice_button_pressed")

	_update_text()

func _update_text():
	text = ""
	$MC/Label.text = _text

	if _text.length() > 200:
		$MC/Label.set("custom_fonts/font", FONT_6)
	elif _text.length() > 100:
		$MC/Label.set("custom_fonts/font", FONT_6)
	else:
		$MC/Label.set("custom_fonts/font", FONT_8)

func _on_choice_button_pressed():
	emit_signal("choice_button_pressed")
