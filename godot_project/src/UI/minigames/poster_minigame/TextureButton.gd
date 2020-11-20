tool
extends Button

export(Texture) var texture setget set_texture, get_texture
func set_texture(value : Texture) -> void:
	texture = value
	$TextureRect.texture = texture
func get_texture() -> Texture:
	return texture
