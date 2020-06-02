extends Control

onready var _quit_button := $VBoxContainer/VBoxContainer/QuitButton
onready var _restart_button := $VBoxContainer/VBoxContainer/RestartButton

func _ready():
	Flow.pause_UI = self
	var _error : int = _restart_button.connect("pressed", self, "_on_restart_button_pressed")

	if OS.get_name() == "HTML5":
		_quit_button.visible = false
	else:
		_quit_button.visible = true
		_error = _quit_button.connect("pressed", self, "_on_quit_button_pressed")

func _on_quit_button_pressed():
	Flow.deferred_quit()

func _on_restart_button_pressed():
	Flow.deferred_reload_current_scene()
