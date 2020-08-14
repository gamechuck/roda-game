extends class_highlight_rect

enum CHARACTER {BABY, CHILD, TEENAGER, ADULT}
export(CHARACTER) var type := CHARACTER.ADULT

var is_valid_character := false

var character : class_character_slot = null setget set_character, get_character
func set_character(value : class_character_slot) -> void:
	character = value
	if character:
		$Sprite.texture = character.texture_normal
		$Sprite.visible = true

		if character.type == type:
			is_valid_character = true
		else:
			is_valid_character = false
	else:
		$Sprite.texture = null
		$Sprite.visible = false

		is_valid_character = false

func get_character() -> class_character_slot:
	return character

func _ready():
	$Sprite.texture = null
