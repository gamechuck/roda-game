extends Node

const OPTIONS_PATH := "res://options.cfg"

var is_in_editor_mode := false

var major_version := 0
var minor_version := 0
var show_version := true

onready var _options_loader := $OptionsLoader

var dialogue_UI : Control = null

func _ready():
	var _error : int = _options_loader.load_optionsCFG()

func _unhandled_input(event : InputEvent):
## Catch all unhandled input not caught be any other control nodes.
	if event.is_action_pressed("toggle_full_screen"):
		OS.window_fullscreen = not OS.window_fullscreen

	if event.is_action_pressed("quit_or_pause"):
		call_deferred("_deferred_quit")

	if event.is_action_pressed("restart"):
		call_deferred("deferred_reload_current_scene")

func _deferred_quit() -> void:
## Quit the game during an idle frame.
	get_tree().quit()

func deferred_reload_current_scene() -> void:
## It is now safe to reload the current scene.
	var _error := get_tree().reload_current_scene()
