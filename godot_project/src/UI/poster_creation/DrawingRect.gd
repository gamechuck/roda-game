extends TextureRect

var font : Font = preload("res://assets/fonts/dynamic/luckiest_guy_size8.tres")

var _image := Image.new()

var background_color := Color.white
var pressed_texture : Texture

func _ready():
	reset()

func reset():
	_image.create(texture.get_width(), texture.get_height(), false, Image.FORMAT_BPTC_RGBA)
	var _error : int = _image.decompress()
	_image.fill(Color.transparent)

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

func update_texture():
	var color_image = _image.duplicate(true)
	color_image.fill(background_color)

	color_image.blend_rect(_image, Rect2(Vector2.ZERO, _image.get_size()), Vector2.ZERO)

	var image_texture = ImageTexture.new()
	print(image_texture.storage)
	image_texture.create_from_image(color_image, 0)
	texture = image_texture
