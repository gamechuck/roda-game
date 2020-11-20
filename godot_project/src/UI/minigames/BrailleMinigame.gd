extends classMinigame

var locale_dict := {
	"hr": preload("res://roda-assets/UI/minigames/braille_minigame/braile_croatian.png"),
	"en": preload("res://roda-assets/UI/minigames/braille_minigame/braile_english.png")
}

func _ready():
	var texture : Texture = locale_dict.get(ConfigData.locale, "hr")

	$VBoxContainer/TextureRect.texture = texture
