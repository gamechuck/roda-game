extends Control

var _texture : Texture

var _drawing_texture : Texture

var _mouse_in_drawing_area := false

func _ready():
	for child in $HBoxContainer/VBoxContainer/SymbolGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_symbol_button_pressed", [child.icon])

	for child in $HBoxContainer/VBoxContainer/SloganGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_symbol_button_pressed", [child.icon])

	for child in $HBoxContainer/VBoxContainer2/BGColorGrid.get_children():
		if child is Button:
			child.connect("pressed", self, "_on_color_button_pressed")

	_drawing_texture = $HBoxContainer/DrawingRect.texture
	$HBoxContainer/DrawingRect.connect("mouse_entered", self, "_on_mouse_entered")
	$HBoxContainer/DrawingRect.connect("mouse_exited", self, "_on_mouse_exited")

func _on_symbol_button_pressed(symbol_texture : Texture):
	_texture = symbol_texture

func _input(event : InputEvent):
	if event.is_action_released("left_mouse_button") and _mouse_in_drawing_area:
		print("released")
		var drawing_data = $HBoxContainer/DrawingRect.texture.get_data()
		var symbol_data = _texture.get_data()
		drawing_data.lock()
		symbol_data.lock()

		print(symbol_data.get_pixel(11, 10) is Color)
		print(symbol_data.get_pixel(15, 9))
		print(symbol_data.get_pixel(26, 7))

		var mouse_offset : Vector2 = $HBoxContainer/DrawingRect.get_local_mouse_position()
		print(mouse_offset)

		for i in symbol_data.get_width():
			for j in symbol_data.get_height():
				var symbol_color : Color = symbol_data.get_pixel(i, j)
				var position := mouse_offset
				position.x += i - symbol_data.get_width()/2
				position.y += j - symbol_data.get_height()/2
				if symbol_color.a != 0:
					drawing_data.set_pixelv(position, symbol_color)

#		data.unlock()
#		data.fill(Color(1,0,0,1))
		var imageTexture = ImageTexture.new()
		imageTexture.create_from_image(drawing_data)
		$HBoxContainer/DrawingRect.texture = imageTexture

func _on_color_button_pressed():
	var data = $HBoxContainer/DrawingRect.texture.get_data()
	data.unlock()
	data.fill(Color(0.94,0.69,97.3,1))
	data.unlock()

	var image_texture := ImageTexture.new()
	image_texture.create_from_image(data)
	$HBoxContainer/DrawingRect.texture = image_texture

func _on_mouse_entered():
	_mouse_in_drawing_area = true

func _on_mouse_exited():
	_mouse_in_drawing_area = false
