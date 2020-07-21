extends class_highlight_rect

onready var _sprite := $Sprite

var character : class_character_slot = null setget set_character, get_character
func set_character(value : class_character_slot) -> void:
	character = value
	if character:
		_sprite.texture = character.texture_normal
		_sprite.visible = true
	else:
		_sprite.texture = null
		_sprite.visible = false
func get_character() -> class_character_slot:
	return character

func _ready():
	_sprite.texture = null
