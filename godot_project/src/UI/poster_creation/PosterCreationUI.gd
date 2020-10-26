extends Control

onready var _clear_button := $HBoxContainer/VBoxContainer2/ClearButton
onready var _drawing_rect := $HBoxContainer/DrawingRect

func _ready():
	var _error := _clear_button.connect("pressed", self, "_on_clear_button_pressed")

	for child in $HBoxContainer/VBoxContainer/SymbolGrid.get_children():
		if child is Button:
			_error = child.connect("pressed", self, "_on_symbol_button_pressed", [child])

	for child in $HBoxContainer/VBoxContainer/SloganGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_slogan_button_pressed", [child])

	for child in $HBoxContainer/VBoxContainer2/BGColorGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_color_button_pressed", [child.color])

func _on_symbol_button_pressed(button : Button):
	var pressed : bool = button.pressed

	for child in $HBoxContainer/VBoxContainer/SymbolGrid.get_children():
		if child is Button:
			if child != button:
				child.pressed = false
			else:
				child.pressed = pressed

				if pressed:
					_drawing_rect.pressed_texture = button.icon
				else:
					_drawing_rect.pressed_texture = null

func _on_slogan_button_pressed(button : Button):
	var pressed : bool = button.pressed

	var image := get_viewport().get_texture().get_data()

	image.flip_y()
	image = image.get_rect(button.get_global_rect())

	var texture = ImageTexture.new()
	texture.flags = 0
	texture.create_from_image(image)

	_drawing_rect.pressed_texture = texture

func _on_color_button_pressed(color : Color):
	_drawing_rect.background_color = color
	_drawing_rect.update_texture()

func _on_clear_button_pressed():
	_drawing_rect.reset()
