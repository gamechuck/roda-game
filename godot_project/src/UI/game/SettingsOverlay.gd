extends MarginContainer

onready var _settings_button := $HB/VB/SettingsButton

func _ready():
	var _error : int = _settings_button.connect("pressed", self, "_on_settings_button_pressed")

func _on_settings_button_pressed() -> void:
	Flow.emit_signal("pause_toggled")
