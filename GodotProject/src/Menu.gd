extends Control

onready var _start_button := $VBoxContainer/StartButton
onready var _quit_button := $VBoxContainer/QuitButton

func _ready():
	var _error : int = _start_button.connect("pressed", self, "_on_start_button_pressed")
	_error = _quit_button.connect("pressed", self, "_on_quit_button_pressed")

func _on_start_button_pressed():
	Flow.change_scene_to("game")

func _on_quit_button_pressed():
	Flow.deferred_quit()
