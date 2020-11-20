class_name classItemState
extends Reference

const FALLBACK_ITEM_TEXTURE := "res://assets/fallback/item_texture.png"

var id := ""
var amount := 1
var pressed := false

var context : Dictionary setget set_context, get_context
func set_context(value : Dictionary) -> void:
	if not value.has("id"):
		push_error("Item context requires id!")
		return

	id = value.id
	# Default amount is 1? I do think so? ...
	amount = value.get("amount", 1)

func get_context() -> Dictionary:
	var _context := {}

	_context.id = id
	_context.amount = amount

	return _context

# These are all constants derived from data.JSON and should be treated as such!
var texture_normal : Texture setget , get_texture_normal
func get_texture_normal():
	if not texture_normal:
		var texture_settings : Dictionary = Flow.get_item_value(id, "textures", {})
		var path : String = texture_settings.get("texture_normal", FALLBACK_ITEM_TEXTURE)
		if ResourceLoader.exists(path):
			texture_normal = load(path)
		else:
			texture_normal = load(FALLBACK_ITEM_TEXTURE)

	return texture_normal

var texture_pressed : Texture setget , get_texture_pressed
func get_texture_pressed():
	if not texture_pressed:
		var texture_settings : Dictionary = Flow.get_item_value(id, "textures", {})
		var path : String = texture_settings.get("texture_pressed", FALLBACK_ITEM_TEXTURE)
		if ResourceLoader.exists(path):
			texture_pressed = load(path)
		else:
			texture_pressed = load(FALLBACK_ITEM_TEXTURE)

	return texture_pressed
