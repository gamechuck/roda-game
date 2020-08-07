extends class_pause_tab

onready var _master_volume_slider := $VBoxContainer/VBoxContainer/MasterVolumeHBox/VolumeSlider
onready var _master_volume_label := $VBoxContainer/VBoxContainer/MasterVolumeHBox/VolumeLabel

onready var _next_button := $VBoxContainer/VBoxContainer/LanguageHBox/NextButton
onready var _previous_button := $VBoxContainer/VBoxContainer/LanguageHBox/PreviousButton

onready var _back_button := $VBoxContainer/BackButton

func _ready():
	var _error : int = _master_volume_slider.connect("value_changed", self, "_on_master_volume_slider_changed")
	_error = _next_button.connect("pressed", self, "_on_language_button_pressed", [+1])
	_error = _previous_button.connect("pressed", self, "_on_language_button_pressed", [-1])
	_error = _back_button.connect("pressed", self, "_on_back_button_pressed")

func update_tab():
	_master_volume_slider.value = ConfigData.master_volume

func _on_master_volume_slider_changed(value : float):
	_master_volume_label.text = "(%3d %%)" % value
	ConfigData.master_volume = value

func _on_language_button_pressed(increment : int):
	var loaded_locales := TranslationServer.get_loaded_locales()
	var index := loaded_locales.find(ConfigData.locale)
	index += increment
	if index >= loaded_locales.size():
		ConfigData.set_locale(loaded_locales[0])
	else:
		ConfigData.set_locale(loaded_locales[index])
