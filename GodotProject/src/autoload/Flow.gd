tool
extends Node

enum LIGHT_COLOR {RED, YELLOW_AFTER_RED, GREEN, YELLOW_AFTER_GREEN}

const OPTIONS_PATH := "res://options.cfg"

const DATA_PATH := "res://data/game_data.json"
const STORY_PATH := "res://data/game_story_hr.ink"

const INKLECATE_PATH : String = "res://inklecate/inklecate.exe"

const DEFAULT_CONTROLS_PATH := "res://default_controls.json"
const USER_CONTROLS_PATH := "user://user_controls.json"

var is_in_editor_mode := false

var major_version := 0
var minor_version := 0
var show_version := true

var is_pause_UI_enabled := true
var start_in_full_screen := false

var MINIMUM_INTERACTION_DISTANCE := 200
var PANIC_MODIFIER := 2.0
var CAR_MOVE_SPEED := 4.0
var PLAYER_MOVE_SPEED := 2.0
var GUMMY_MODIFIER := 0.5
var BIKE_MODIFIER := 2.0
var TRAFFIC_RED_TIME := 10.0
var TRAFFIC_YELLOW_AFTER_RED_TIME := 0.5
var TRAFFIC_YELLOW_AFTER_GREEN_TIME := 0.5
var TRAFFIC_GREEN_TIME := 10.0
var FALLBACK_INVENTORY_TEXTURE := "res://resources/fallback/inventory_texture.png"

onready var _options_loader := $OptionsLoader
onready var _controls_loader := $ControlsLoader
onready var _data_loader := $DataLoader

var _story_resource := load("res://addons/inkgd/runtime/story.gd")

var dialogue_UI : Control = null
var	pause_UI : Control = null
var bike_repair_UI : Control = null
var inventory_overlay : Control = null
var game_canvas : Node2D = null

var player : KinematicBody2D = null

var active_character : class_character = null
var active_item : class_item = null
var active_item_slot : class_item_slot = null

var character_data := {}
var item_data := {}

func _ready():
	if not Engine.editor_hint:
		var _error := load_settings()
		OS.window_fullscreen = start_in_full_screen

func load_settings() -> int:
	print("----- (Re)loading game settings from file -----")
	var _error : int = _options_loader.load_optionsCFG()
	_error += _controls_loader.load_controlsJSON()
	_error += _data_loader.load_dataJSON()
	if _error == OK:
		print("----> Succesfully loaded settings!")
	else:
		push_error("Failed to load settings! Check console for clues!")
	return _error

func load_story():
	if OS.get_name() == "Windows":
		var _error = build_INK(STORY_PATH, INKLECATE_PATH)
	var content = load_INK(Flow.STORY_PATH)
	dialogue_UI.story = _story_resource.new(content)

	# Bind the getter functions so the story can access the game's state.
	dialogue_UI.story.bind_external_function_general("has_item", inventory_overlay, "has_item")

	# Bind an observer to some variables
	dialogue_UI.story.observe_variables(["number_of_fences_fixed"], self, "_observe_variables")

func _observe_variables(variable_name, new_value):
	match variable_name:
		"number_of_fences_fixed":
			game_canvas.increment_visible_fences()
	print(str("Variable '", variable_name, "' changed to: ", new_value))

func _unhandled_input(event : InputEvent):
## Catch all unhandled input not caught be any other control nodes.
	if Engine.editor_hint:
		return

	if event.is_action_pressed("toggle_full_screen"):
		OS.window_fullscreen = not OS.window_fullscreen

	if event.is_action_pressed("quit_or_pause"):
		quit_or_pause_game()

	if event.is_action_pressed("restart"):
		call_deferred("deferred_reload_current_scene")

func deferred_quit() -> void:
## Quit the game during an idle frame.
	get_tree().quit()

func deferred_reload_current_scene() -> void:
## It is now safe to reload the current scene.
	var _error := load_settings()
	_error = get_tree().reload_current_scene()
	get_tree().paused = false

func quit_or_pause_game():
	if is_pause_UI_enabled:
		pause_UI.visible = not get_tree().paused
		get_tree().paused = not get_tree().paused
	else:
		call_deferred("deferred_quit")

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
# Load a JSON-file, convert it to a dictionary and return it.
	var file : File = File.new()
	var dictionary := {}
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

static func load_INK(path : String) -> String:
# Load an INK-file, convert it to a string and return it.
	var extended_path : String = "{0}.json".format([path])
	var file = File.new()
	var string : String = ""
	var error : int = file.open(extended_path, File.READ)
	if error == OK:
		string = file.get_as_text()
		file.close()
		return string
	else:
		push_error("Failed to open the compiled INK file at '{0}'.".format([extended_path]))
		return '{"inkVersion":19,"root":[[["done",{"#n":"g-0"}],null],"done",{"#f":3}],"listDefs":{}}'

static func build_INK(path : String, inklecate_path : String) -> int:
## Compile an INK file at location path to a JSON file at the same location.
	var source_path: String = "{0}".format([path])
	var target_path: String = "{0}.json".format([path])
	var file : File = File.new()

	# Check if all necessary files/executables exist!
	if not file.file_exists(source_path):
		push_error("INK-file with path '{0}' did not exist! Aborting building function...".format([source_path]))
		return ERR_FILE_NOT_FOUND

	var output := []

	if not file.file_exists(inklecate_path):
		push_error("Failed to find Inklecate building tool '{0}', check path availability!".format([inklecate_path]))
		return ERR_FILE_NOT_FOUND

	inklecate_path = ProjectSettings.globalize_path(inklecate_path)
	var exit_code = OS.execute(inklecate_path, [
				   '-o',
				   ProjectSettings.globalize_path(target_path),
				   ProjectSettings.globalize_path(source_path)
			   ], true, output)
	if exit_code != OK:
		push_error("Building failed with exit code '{0}', check console for more information.".format([exit_code]))

	# Outputing a BOM is inklecate's way of saying that everything went through.
	# This is fragile. There might be a better option to express the BOM, or maybe
	# check for inklecate's return code?
	#
	# On macOS the length of the BOM is 3, on Windows the length of the BOM is 0,
	# that's fairly strange.
	if output.size() == 1 && (output[0].length() == 3 || output[0].length() == 0):
		print(output[0] + "Compiled story to: " + target_path)
	else:
		print(PoolStringArray(output).join("\n"))

		# TODO: It might be useful to analyze the exit_code in some way?
		if (output.size() == 1 and output[0].length() == 0):
			print(output[0] + "Compiled story to: " + target_path)
		else:
			print(PoolStringArray(output).join("\n"))

	return OK
