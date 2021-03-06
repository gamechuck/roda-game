extends TextureRect

const UNDO_STACK_SIZE := 5

var pressed_texture : Texture

var foreground_image := Image.new()
var previous_foreground_images := []

var background_color : Color

signal stack_updated

func _gui_input(event : InputEvent):
	if event.is_action_released("left_mouse_button") and pressed_texture:
		# Push the previous foreground image to the stack!
		_push_to_stack(foreground_image.duplicate())

		var pressed_data = pressed_texture.get_data()
		#var _error : int = pressed_data.decompress()

		foreground_image.lock()
		pressed_data.lock()

		var mouse_offset := get_local_mouse_position()
		var rect := Rect2(Vector2.ZERO, foreground_image.get_size())

		for i in pressed_data.get_width():
			for j in pressed_data.get_height():
				var pressed_color : Color = pressed_data.get_pixel(i, j)
				var position := mouse_offset
				position.x += i - pressed_data.get_width()/2
				position.y += j - pressed_data.get_height()/2
				if rect.has_point(Vector2(position)):
					var image_color := foreground_image.get_pixelv(position)
					foreground_image.set_pixelv(position, image_color.blend(pressed_color))

		update_texture()

func _push_to_stack(image : Image):
	previous_foreground_images.push_front(image)
	if previous_foreground_images.size() > UNDO_STACK_SIZE:
		previous_foreground_images.pop_back()

	emit_signal("stack_updated")

func undo_texture() -> void:
	var previous_image = previous_foreground_images.pop_front()
	if previous_image != null:
		foreground_image = previous_image
		update_texture()

	emit_signal("stack_updated")

func reset_texture():
	# Push the previous foreground image to the stack... if it exists!
	if not foreground_image.is_empty():
		_push_to_stack(foreground_image.duplicate())

	foreground_image.create(texture.get_width(), texture.get_height(), false, Image.FORMAT_RGBA8)
	var _error : int = foreground_image.decompress()
	foreground_image.fill(Color.transparent)

	update_texture()

func update_texture():
	var image = foreground_image.duplicate(true)
	image.fill(background_color)

	image.blend_rect(foreground_image, Rect2(Vector2.ZERO, foreground_image.get_size()), Vector2.ZERO)

	var image_texture = ImageTexture.new()
	image_texture.create_from_image(image, 0)
	texture = image_texture
