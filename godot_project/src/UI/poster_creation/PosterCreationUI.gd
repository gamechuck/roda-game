extends Control

onready var _clear_button := $VBoxContainer/HBoxContainer/VBoxContainer2/ClearButton
onready var _drawing_rect := $VBoxContainer/HBoxContainer/DrawingRect

var _children := []

func _ready():
	var _error := _clear_button.connect("pressed", self, "_on_clear_button_pressed")

	_children = $VBoxContainer/HBoxContainer/VBoxContainer/SymbolGrid.get_children()
	_children += $VBoxContainer/HBoxContainer/VBoxContainer/SloganGrid.get_children()

	for child in _children:
		if child is Button:
			_error = child.connect("pressed", self, "_on_icon_button_pressed", [child])

	for child in $VBoxContainer/HBoxContainer/VBoxContainer2/BGColorGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_color_button_pressed", [child.color])

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
