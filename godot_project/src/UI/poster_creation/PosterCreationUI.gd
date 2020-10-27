extends Control

onready var _clear_button := $VBoxContainer/HBoxContainer/VBoxContainer2/ClearButton
onready var _drawing_rect := $VBoxContainer/HBoxContainer/DrawingRect

onready var _done_button :=  $VBoxContainer/DoneButton

var _children := []

signal done_button_pressed

func _ready():
	Flow.poster_creation_UI = self

	var _error := _done_button.connect("pressed", self, "_on_done_button_pressed")
	_error = connect("done_button_pressed", Director, "_on_choice_button_pressed")

	_error = _clear_button.connect("pressed", self, "_on_clear_button_pressed")

	_children = $VBoxContainer/HBoxContainer/VBoxContainer/SymbolGrid.get_children()
	_children += $VBoxContainer/HBoxContainer/VBoxContainer/SloganGrid.get_children()

	for child in _children:
		if child is Button:
			_error = child.connect("pressed", self, "_on_icon_button_pressed", [child])

	for child in $VBoxContainer/HBoxContainer/VBoxContainer2/BGColorGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_color_button_pressed", [child.color])

func show():
	visible = true

func hide():
	visible = false

func _on_icon_button_pressed(button : Button):
	var pressed : bool = button.pressed

	for child in _children:
		if child is Button:
			if child != button:
				child.pressed = false
			else:
				child.pressed = pressed

				if pressed:
					_drawing_rect.pressed_texture = button.icon
				else:
					_drawing_rect.pressed_texture = null

func _on_color_button_pressed(color : Color):
	_drawing_rect.background_color = color
	_drawing_rect.update_texture()

func _on_clear_button_pressed():
	_drawing_rect.reset()

func _on_done_button_pressed():
	if ConfigData.verbose_mode : print("POSTER CREATION - done!")
	Flow.poster_texture = _drawing_rect.texture
	for billboard in get_tree().get_nodes_in_group("billboards"):
		billboard.update_poster()

	emit_signal("done_button_pressed", 0)
