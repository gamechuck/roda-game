extends class_menu_tab

onready var _start_button := $VBoxContainer/VBoxContainer/StartButton
onready var _settings_button := $VBoxContainer/VBoxContainer/SettingsButton
onready var _quit_button := $VBoxContainer/VBoxContainer/QuitButton

func _ready():
	var _error : int = _start_button.connect("pressed", self, "_on_start_button_pressed")
	_error = _settings_button.connect("pressed", self, "_on_settings_button_pressed")

	if OS.get_name() == "HTML5":
		_quit_button.visible = false
	else:
		_quit_button.visible = true
		_error = _quit_button.connect("pressed", self, "_on_quit_button_pressed")

func update_tab():
	AudioEngine.play_background_music("title")
	_start_button.grab_focus()

func _on_start_button_pressed():
	Flow.change_scene_to("game")

func _on_settings_button_pressed():
	emit_signal("button_pressed", TABS.SETTINGS)
