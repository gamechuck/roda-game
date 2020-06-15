extends pause_tab

onready var _volume_slider := $VBoxContainer/VBoxContainer/VolumeHBox/VolumeSlider
onready var _volume_label := $VBoxContainer/VBoxContainer/VolumeHBox/VolumeLabel

onready var _next_button := $VBoxContainer/VBoxContainer/LanguageHBox/NextButton
onready var _previous_button := $VBoxContainer/VBoxContainer/LanguageHBox/PreviousButton

onready var _back_button := $VBoxContainer/BackButton

func _ready():
	var _error : int = _volume_slider.connect("value_changed", self, "_on_volume_slider_changed")
	_error = _next_button.connect("pressed", self, "_on_language_button_pressed", [+1])
	_error = _previous_button.connect("pressed", self, "_on_language_button_pressed", [-1])
	_error = _back_button.connect("pressed", self, "_on_back_button_pressed")

func _on_volume_slider_changed(value : float):
	_volume_label.text = "(%3d %%)" % value
	var volume_db : float = 20*log(float(value)/100.0)/log(10.0)
	# -INF (when new_value = 0) doesn't seem to pose any issues!
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

func _on_language_button_pressed(increment : int):
	var locale := TranslationServer.get_locale()
	var loaded_locales := TranslationServer.get_loaded_locales()
	var index := loaded_locales.find(locale)
	index += increment
	if index >= loaded_locales.size():
		locale = loaded_locales[0]
	else:
		locale = loaded_locales[index]
	TranslationServer.set_locale(locale)

func _on_back_button_pressed():
	emit_signal("change_tab_requested", TABS.MAIN)
