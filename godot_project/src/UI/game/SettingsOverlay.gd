extends MarginContainer

onready var _settings_button := $HBoxContainer/VBoxContainer/SettingsButton

func _ready():
	var _error : int = _settings_button.connect("pressed", Flow, "toggle_paused")
