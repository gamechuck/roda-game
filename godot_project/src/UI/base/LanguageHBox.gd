extends HBoxContainer

func _ready():
	var _error : int = $NextButton.connect("pressed", self, "_on_language_button_pressed", [+1])
	_error = $PreviousButton.connect("pressed", self, "_on_language_button_pressed", [-1])

func _on_language_button_pressed(increment : int):
	var loaded_locales := TranslationServer.get_loaded_locales()
	var unique_locales := []
	# loaded_locales can contain duplicate locales, wihch should be avoided!
	for locale in loaded_locales:
		if not locale in unique_locales:
			unique_locales.append(locale)

	var index := unique_locales.find(ConfigData.locale)
	index += increment
	if index >= unique_locales.size():
		ConfigData.set_locale(unique_locales[0])
	else:
		ConfigData.set_locale(unique_locales[index])

func update_setting() -> void:
	# This method isn't actually required since the label gets automatically
	# updated by the TranslationServer.
	pass
