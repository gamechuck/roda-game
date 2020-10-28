class_name classCharacterState
extends Reference

const FALLBACK_CHARACTER_TEXTURE := "res://resources/fallback/character_texture.png"

var id := ""
var properties := {}

var visible := true
# The actual visual representation of this state.
var object : KinematicBody2D = null

var context : Dictionary setget set_context, get_context
func set_context(value : Dictionary) -> void:
	if not value.has("id"):
		push_error("Character context requires id!")
		return

	id = value.id
	# Merge the context properties with the default ones.
	var _properties : Dictionary = value.get("properties", {})
	for key in _properties.keys():
		if properties.has(key):
			properties[key] = _properties[key]
		else:
			push_error("Property with key '{0}' is undefined in character with id '{1}'!".format([key, id]))

	# Overwrite the visibility if defined by the state!
	visible = value.get("visible", visible)

func get_context() -> Dictionary:
	var _context := {}

	# TODO: Don't save anything if all properties are the default state!
	_context.id = id
	_context.properties = {}
	var _properties : Dictionary = Flow.get_character_value(id, "properties", {})
	for key in _properties.keys():
		if _properties[key] != properties[key]:
			_context.properties[key] = properties[key]

	if _context.properties.is_empty():
		return {}
	else:
		return _context

# These are all constants derived from data.JSON and should be treated as such!
var name : String setget , get_name
func get_name():
	return Flow.get_character_value(id, "name", "MISSING NAME")

var knot : String setget , get_knot
func get_knot():
	return Flow.get_character_value(id, "knot", "MISSING KNOT")

var portrait_texture : Texture setget , get_portrait_texture
func get_portrait_texture():
	var portrait_settings : Dictionary = Flow.get_character_value(id, "portrait", {})
	var path : String = portrait_settings.get("texture", "")
	if ResourceLoader.exists(path):
		return load(path)
	else:
		return null

var portrait_size : Vector2 setget , get_portrait_size
func get_portrait_size():
	var portrait_settings : Dictionary = Flow.get_character_value(id, "portrait", {})
	var size_array : Array = portrait_settings.get("size", [200, 200])
	if size_array.size() == 2:
		return Vector2(size_array[0], size_array[1])
	else:
		return 200*Vector2.ONE

var portrait_position : Vector2 setget , get_portrait_position
func get_portrait_position():
	var portrait_settings : Dictionary = Flow.get_character_value(id, "portrait", {})
	var size_array : Array = portrait_settings.get("position", [0, 0])
	if size_array.size() == 2:
		return Vector2(size_array[0], size_array[1])
	else:
		return Vector2.ZERO

var flip_h : bool setget , get_flip_h
func get_flip_h():
	var portrait_settings : Dictionary = Flow.get_character_value(id, "portrait", {})
	return portrait_settings.get("flip_h", false)

var flip_v : bool setget , get_flip_v
func get_flip_v():
	var portrait_settings : Dictionary = Flow.get_character_value(id, "portrait", {})
	return portrait_settings.get("flip_v", false)
