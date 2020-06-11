extends Control

onready var _quit_button := $VBoxContainer/VBoxContainer/QuitButton
onready var _resume_button := $VBoxContainer/VBoxContainer/ResumeButton
onready var _restart_button := $VBoxContainer/VBoxContainer/RestartButton
onready var _volume_slider := $VBoxContainer/VBoxContainer/HBoxContainer/VolumeSlider
onready var _volume_label := $VBoxContainer/VBoxContainer/HBoxContainer/VolumeLabel

func _ready():
	Flow.pause_UI = self
	var _error : int = _restart_button.connect("pressed", self, "_on_restart_button_pressed")
	_error = _resume_button.connect("pressed", self, "_on_resume_button_pressed")
	_error = _volume_slider.connect("value_changed", self, "_on_volume_slider_changed")

	if OS.get_name() == "HTML5":
		_quit_button.visible = false
	else:
		_quit_button.visible = true
		_error = _quit_button.connect("pressed", self, "_on_quit_button_pressed")

func _on_quit_button_pressed():
	Flow.deferred_quit()

func _on_resume_button_pressed():
	Flow.quit_or_pause_game()

func _on_restart_button_pressed():
	Flow.deferred_reload_current_scene()

func _on_volume_slider_changed(value : float):
	_volume_label.text = "(%3d %%)" % value
	var volume_db : float = 20*log(float(value)/100.0)/log(10.0)
	# -INF (when new_value = 0) doesn't seem to pose any issues!
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)
