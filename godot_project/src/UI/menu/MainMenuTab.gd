extends classMenuTab

onready var _start_button := $VBoxContainer/VBoxContainer/StartButton
onready var _how_to_play_button := $VBoxContainer/VBoxContainer/HowToPlayButton
onready var _about_button := $VBoxContainer/VBoxContainer/AboutButton
onready var _settings_button := $VBoxContainer/VBoxContainer/SettingsButton

onready var _quit_button := $VBoxContainer/QuitButton

func _ready():
	var _error : int = _start_button.connect("pressed", self, "_on_start_button_pressed")
	_error = _how_to_play_button.connect("pressed", self, "_on_how_to_play_button_pressed")
	_error = _about_button.connect("pressed", self, "_on_about_button_pressed")
	_error = _settings_button.connect("pressed", self, "_on_settings_button_pressed")

	# Hide the quit button if the OS is HTML!
	# Since this button won't work anyway...
	if OS.get_name() == "HTML5":
		_quit_button.visible = false
	else:
		_quit_button.visible = true
		_error = _quit_button.connect("pressed", self, "_on_quit_button_pressed")

func update_tab():
	_start_button.grab_focus()

func _on_start_button_pressed():
	emit_signal("button_pressed", TABS.SELECT_LEVEL)

func _on_how_to_play_button_pressed():
	emit_signal("button_pressed", TABS.HOW_TO_PLAY)

func _on_about_button_pressed():
	emit_signal("button_pressed", TABS.ABOUT)

func _on_settings_button_pressed():
	emit_signal("button_pressed", TABS.SETTINGS)
