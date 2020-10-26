extends TextureRect

var font : Font = preload("res://assets/fonts/dynamic/luckiest_guy_size8.tres")

var _image := Image.new()
var _temp_image := Image.new()

var _clear_texture := ImageTexture.new()

var background_color := Color.white
var pressed_texture : Texture

func _ready():
	reset()

	texture = _clear_texture
	print(texture.get_size())
	update()

func reset():
	_image.create(texture.get_width(), texture.get_height(), false, Image.FORMAT_BPTC_RGBA)
	var _error : int = _image.decompress()
	_image.fill(Color.transparent)

	var _clear_texture = ImageTexture.new()
	_clear_texture.flags = 0
	_clear_texture.create_from_image(_image)

	background_color = Color.white

	update_texture()

func _gui_input(event : InputEvent):
	if event.is_action_released("left_mouse_button") and pressed_texture:
		var pressed_data = pressed_texture.get_data()
		_image.lock()
		pressed_data.lock()

		var mouse_offset := get_local_mouse_position()
		var rect := Rect2(Vector2.ZERO, _image.get_size())

		for i in pressed_data.get_width():
			for j in pressed_data.get_height():
				var pressed_color : Color = pressed_data.get_pixel(i, j)
				var position := mouse_offset
				position.x += i - pressed_data.get_width()/2
				position.y += j - pressed_data.get_height()/2
				if rect.has_point(Vector2(position)):
					var image_color := _image.get_pixelv(position)
					_image.set_pixelv(position, image_color.blend(pressed_color))

		update_texture()

var text := "GFRREG"

func _draw():
	#draw_string(font, Vector2.ZERO, text, Color.red)

	if not text.empty():

		print(text)

		draw_string(font, 100*Vector2.ONE, text, Color.red)

		#text = ""

		#_temp_image = texture.get_data().duplicate(true)

		update_texture()

func update_texture():
	return
	var color_image = _image.duplicate(true)
	color_image.fill(background_color)

	print(_temp_image)
	print(_temp_image.is_empty())
	if not _temp_image.is_empty():
		_image.blend_rect(_temp_image, Rect2(Vector2.ZERO, _temp_image.get_size()), Vector2.ZERO)
		_temp_image = Image.new()

	color_image.blend_rect(_image, Rect2(Vector2.ZERO, _image.get_size()), Vector2.ZERO)

	var image_texture = ImageTexture.new()
	image_texture.flags = 0
	image_texture.create_from_image(color_image)
	texture = image_texture
