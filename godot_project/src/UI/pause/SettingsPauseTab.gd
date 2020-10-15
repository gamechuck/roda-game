extends classPauseTab

onready var _back_button := $VBoxContainer/BackButton

onready var _settings_vbox := $VBoxContainer/SettingsVBox

func _ready():
	var _error : int = _back_button.connect("pressed", self, "_on_back_button_pressed")

func update_tab():
	_back_button.grab_focus()

	update_settings()

func update_settings() -> void:
	for child in _settings_vbox.get_children():
		if child.has_method("update_setting"):
			child.update_setting()

func _on_back_button_pressed() -> void:
	# Save the user-settings to the local system.
	var _error := ConfigData.save_settingsCFG()
	if _error != OK:
		push_error("Failed to save settings to local storage! Check console for clues!")

	._on_back_button_pressed()
