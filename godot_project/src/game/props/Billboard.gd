extends classProp

func _ready():
	add_to_group("billboards")

	update_poster()

func update_poster():
	if not State.foreground_image.is_empty():
		var image = State.foreground_image.duplicate(true)
		image.fill(State.background_color)

		image.blend_rect(State.foreground_image, Rect2(Vector2.ZERO, State.foreground_image.get_size()), Vector2.ZERO)

		var image_texture = ImageTexture.new()
		image_texture.create_from_image(image, 0)
		$Sprite/Poster.texture = image_texture

