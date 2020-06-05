extends Node

enum LIGHT_COLOR {RED, YELLOW_AFTER_RED, GREEN, YELLOW_AFTER_GREEN}

const OPTIONS_PATH := "res://options.cfg"

const DATA_PATH := "res://data/game_data.json"

const DEFAULT_CONTROLS_PATH := "res://default_controls.json"
const USER_CONTROLS_PATH := "user://user_controls.json"

var is_in_editor_mode := false

var major_version := 0
var minor_version := 0
var show_version := true

var is_pause_UI_enabled := true
var start_in_full_screen := false

var PANIC_MODIFIER := 2.0
var CAR_MOVE_SPEED := 4.0
var PLAYER_MOVE_SPEED := 2.0
var GUMMY_MODIFIER := 0.5
var BIKE_MODIFIER := 2.0
var MAX_AMOUNT_OF_CARS := 10
var MINIMUM_TIME_BETWEEN_CARS := 0.75
var MAXIMUM_TIME_BETWEEN_CARS := 1.75
var TRAFFIC_RED_TIME := 2.0
var TRAFFIC_YELLOW_AFTER_RED_TIME := 2.0
var TRAFFIC_YELLOW_AFTER_GREEN_TIME := 2.0
var TRAFFIC_GREEN_TIME := 2.0

onready var _options_loader := $OptionsLoader
onready var _controls_loader := $ControlsLoader
onready var _data_loader := $DataLoader

var dialogue_UI : Control = null
var	pause_UI : Control = null
var inventory_overlay : Control = null

var item_being_dragged : class_inventory_item = null
var active_character : class_character = null

var character_data := {}
var item_data := {}

func _ready():
	var _error : int = _options_loader.load_optionsCFG()
	_error = _controls_loader.load_controlsJSON()
	OS.window_fullscreen = start_in_full_screen

func load_game_data():
	var _error : int = _data_loader.load_dataJSON()

func _unhandled_input(event : InputEvent):
## Catch all unhandled input not caught be any other control nodes.
	if event.is_action_pressed("toggle_full_screen"):
		OS.window_fullscreen = not OS.window_fullscreen

	if event.is_action_pressed("quit_or_pause"):
		if is_pause_UI_enabled:
			pause_UI.visible = not get_tree().paused
			get_tree().paused = not get_tree().paused
		else:
			call_deferred("deferred_quit")

	if event.is_action_pressed("restart"):
		call_deferred("deferred_reload_current_scene")

func deferred_quit() -> void:
## Quit the game during an idle frame.
	get_tree().quit()

func deferred_reload_current_scene() -> void:
## It is now safe to reload the current scene.
	var _error := get_tree().reload_current_scene()
	get_tree().paused = false

func get_character_data(character_id : String) -> Dictionary:
	if character_data.has(character_id):
		return character_data[character_id].duplicate(true)
	else:
		push_error("Failed to get data for character with id '{0}'.".format([character_id]))
	return {}

func get_item_data(item_id : String) -> Dictionary:
	if item_data.has(item_id):
		return item_data[item_id].duplicate(true)
	else:
		push_error("Failed to get data for item with id '{0}'.".format([item_id]))
	return {}

static func load_JSON(path : String) -> Dictionary:
# Load a JSON-file and convert it to a dictionary and return it.
	var file : File = File.new()
	var dictionary : Dictionary
	var error : int = file.open(path, File.READ)
	if error == OK:
		var text : String = file.get_as_text()
		file.close()
		if typeof(parse_json(text)) != TYPE_NIL:
			dictionary = parse_json(text)
			if dictionary == null:
				push_error("Detected null-value in JSON at {0}.".format([path]))
			else:
				return dictionary

		push_error("Failed to correctly process '{0}', check file format!".format([path]))
		return {}
	else:
		push_error("Failed to open '{0}', check file availability!".format([path]))
		return {}
