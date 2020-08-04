tool
extends Node

enum STATE {MENU, GAME}

const DEFAULT_OPTIONS_PATH := "res://default_options.cfg"
# Settings are a subset of options that can be modified by the user.
const USER_SETTINGS_PATH := "user://user_settings.cfg"

const DEFAULT_CONTROLS_PATH := "res://default_controls.json"
const USER_CONTROLS_PATH := "user://user_controls.json"

const DATA_PATH := "res://data/game_data.json"
const STORY_PATH := "res://data/game_story_hr.ink"

const INKLECATE_PATH : String = "res://inklecate/inklecate.exe"

### PUBLIC VARIABLES ###

var dialogue_UI : Control = null
var	pause_UI : Control = null
var transitions_UI : Control = null
var bike_repair_UI : Control = null
var car_seat_belt_UI : Control = null
var inventory_overlay : Control = null
var game_canvas : Node2D = null

var player : KinematicBody2D = null

# Is the game currently in editor mode? or not?
var is_in_editor_mode := false

var character_data := {}
var item_data := {}

var _game_flow := {
	"game": {
		"packed_scene": preload("res://src/Game.tscn"),
		"state": STATE.GAME
		}, 
	"menu": {
		"packed_scene": preload("res://src/Menu.tscn"),
		"state": STATE.MENU
		}
	}
var _game_state : int = STATE.MENU
var _story_resource := load("res://addons/inkgd/runtime/story.gd")

var active_character : class_character = null
var active_item : class_item = null
var active_inventory_item : class_inventory_item = null

onready var _options_loader := $OptionsLoader
onready var _controls_loader := $ControlsLoader
onready var _data_loader := $DataLoader
onready var _state_loader := $StateLoader

func _ready():
	# Disable input so that this doesn't throw an error due to not finding
	# the required action strings.
	set_process_unhandled_input(false)
	
	if not Engine.editor_hint:
		var _error := load_settings()
		reset()
		print(                                                                                
			"      _____    _  _____ \n",
			" ___ |     | _| ||  _  |\n",
			"|  _||  |  || . ||     |\n",
			"|_|  |_____||___||__|__|\n"                                                     
		)
		print("version {0}.{1}".format([ 
			ConfigData.major_version, 
			ConfigData.minor_version]))

		if ConfigData.skip_menu:
			if ConfigData.verbose_mode : print("Automatically skipping menu as requested by configuration data...")
			change_scene_to("game")
		else:
			change_scene_to("menu")

		set_process_unhandled_input(true)

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

func reset():
	is_in_editor_mode = false

func load_story():
	if OS.get_name() == "Windows":
		var _error = build_INK(STORY_PATH, INKLECATE_PATH)
	var content = load_INK(STORY_PATH)
	dialogue_UI.story = _story_resource.new(content)

	# Bind the getter functions so the story can access the game's state.
	# Check if the player has an item in its inventory...
	dialogue_UI.story.bind_external_function_general("has_item", inventory_overlay, "has_item")
	# Get the state of the node that is participating in the dialogue.
	dialogue_UI.story.bind_external_function_general("get_state", dialogue_UI, "get_state")

	# Bind an observer to some variables
	dialogue_UI.story.observe_variables(["number_of_fences_fixed"], self, "_observe_variables")

func _observe_variables(variable_name, new_value):
	match variable_name:
		"number_of_fences_fixed":
			game_canvas.increment_visible_fences()
	print(str("Variable '", variable_name, "' changed to: ", new_value))

func _unhandled_input(event : InputEvent):
## Catch all unhandled input not caught be any other control nodes.
	if InputMap.has_action("toggle_full_screen") and event.is_action_pressed("toggle_full_screen"):
		OS.window_fullscreen = not OS.window_fullscreen

	match _game_state:
		STATE.GAME:
			if InputMap.has_action("toggle_paused") and event.is_action_pressed("toggle_paused"):
				print("pause has been pressed!!")
				toggle_paused()
			if InputMap.has_action("restart") and event.is_action_pressed("restart"):
				call_deferred("deferred_reload_current_scene")
			if InputMap.has_action("toggle_editor_mode") and event.is_action_pressed("toggle_editor_mode"):
				toggle_editor_mode()

func toggle_editor_mode():
	is_in_editor_mode = not is_in_editor_mode

func toggle_paused():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		pause_UI.show()
	else:
		pause_UI.hide()

func deferred_quit() -> void:
## Quit the game during an idle frame.
	get_tree().quit()

func deferred_reload_current_scene() -> void:
## It is now safe to reload the current scene.
	var _error := load_settings()
	_error = get_tree().reload_current_scene()
	get_tree().paused = false

func change_scene_to(key : String) -> void:
	if _game_flow.has(key):
		var state_settings : Dictionary = _game_flow[key]
		var packed_scene : PackedScene = state_settings.packed_scene
		_game_state = state_settings.state

		var error := get_tree().change_scene_to(packed_scene)
		get_tree().paused = false
		reset()
		if error != OK:
			push_error("Failed to change scene to '{0}'.".format([key]))
		else:
			print("Succesfully changed scene to '{0}'.".format([key]))
	else:
		push_error("Requested scene '{0}' was not recognized... ignoring call for changing scene.".format([key]))

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
