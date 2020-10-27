extends Node

enum STATE {STARTUP, MENU, GAME }

const DEFAULT_OPTIONS_PATH := "res://default_options.cfg"
# Settings are a subset of options that can be modified by the user.
const USER_SETTINGS_PATH := "user://user_settings.cfg"

const DEFAULT_CONTROLS_PATH := "res://default_controls.json"
const USER_CONTROLS_PATH := "user://user_controls.json"

const SAVE_FOLDER := "user://saves"

const DEFAULT_CONTEXT_PATH := "res://default_context.json"
const USER_SAVE_PATH := SAVE_FOLDER + "/user_save.json"

const DATA_PATH := "res://data/data.json"
const STORY_PATH := "res://data/story_hr.ink"

### PUBLIC VARIABLES ###
var dialogue_UI : Control = null
var	pause_UI : Control = null
var transitions_UI : Control = null
var bike_repair_UI : Control = null
var poster_creation_UI : Control = null
var seat_sorting_UI : Control = null
var inventory : Control = null
var game_canvas : Node2D = null
var boss_overlay : Control = null

var player : KinematicBody2D = null

# Is the game currently in editor mode? or not?
var is_in_editor_mode := false

var characters_data := {}
var items_data := {}
var pickups_data := {}

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
var _game_state : int = STATE.STARTUP
var _story_resource := preload("res://addons/inkgd/runtime/story.gd")

var player_is_active := false
var active_character : classCharacter
var active_pickup : classPickup
var active_item : classItemState

var poster_texture : Texture

onready var _controls_loader := $ControlsLoader
onready var _data_loader := $DataLoader

func _ready():
	var _error := load_settings()
	if ConfigData.verbose_mode:
		print(
			"      _____    _  _____ \n",
			" ___ |     | _| ||  _  |\n",
			"|  _||  |  || . ||     |\n",
			"|_|  |_____||___||__|__|\n"
		)
		# ASCII -> Rectangles
		print("version {0}.{1}".format([
			ConfigData.major_version,
			ConfigData.minor_version]))

func load_settings() -> int:
	print("----- (Re)loading game settings from file -----")
	var _error : int = ConfigData.load_optionsCFG()
	_error += _controls_loader.load_controlsJSON()
	_error += _data_loader.load_dataJSON()

	# Also load the default context..
	# might autoload the user_context in the future here?
	_error += State.load_stateJSON()
	if _error == OK:
		print("----> Succesfully loaded settings!")
	else:
		push_error("Failed to load settings! Check console for clues!")
	return _error

func load_story():
	if OS.get_name() == "Windows":
		var _error = build_INK(STORY_PATH)
	var content = load_INK(STORY_PATH)
	var story : Object = _story_resource.new(content)

	# Bind the getter functions so the story can access the game's state.
	# Check if the player has an item in its inventory...
	story.bind_external_function_general("has_item", State, "has_item")
	# Get the state of the node that is participating in the dialogue.
	story.bind_external_function_general("get_state_property", Director, "get_state_property")

	# Bind an observer to some variables
	story.observe_variables(["number_of_fences_fixed", "turbine_fixed", "player_wearing_color"], self, "_observe_variables")

	Director.story = story

func _observe_variables(variable_name, new_value):
	match variable_name:
		"number_of_fences_fixed":
			game_canvas._on_number_of_fences_fixed(new_value)
		"turbine_fixed":
			game_canvas._on_turbine_fixed(new_value)
		"player_wearing_color":
			game_canvas._on_player_wearing_color(new_value)
	print(str("Variable '", variable_name, "' changed to: ", new_value))

func get_item_value(id : String, key : String, default):
	if items_data.has(id):
		var data : Dictionary = items_data[id]
		return data.get(key, default)
	else:
		return default

func get_pickup_value(id : String, key : String, default):
	if pickups_data.has(id):
		var data : Dictionary = pickups_data[id]
		return data.get(key, default)
	else:
		return default

func get_character_value(id : String, key : String, default):
	if characters_data.has(id):
		var data : Dictionary = characters_data[id]
		return data.get(key, default)
	else:
		return default

func _unhandled_input(event : InputEvent):
## Catch all unhandled input not caught be any other control nodes.
	if InputMap.has_action("toggle_full_screen") and event.is_action_pressed("toggle_full_screen"):
		OS.window_fullscreen = not OS.window_fullscreen

	if InputMap.has_action("reload_all") and event.is_action_pressed("reload_all"):
		call_deferred("deferred_reload_current_scene")

	match _game_state:
		STATE.GAME:
			if InputMap.has_action("toggle_paused") and event.is_action_pressed("toggle_paused"):
				toggle_paused()

func toggle_paused():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		pause_UI.show()
	else:
		pause_UI.hide()

func toggle_inventory():
	inventory.pressed = not inventory.pressed

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
		if error != OK:
			push_error("Failed to change scene to '{0}'.".format([key]))
		else:
			print("Succesfully changed scene to '{0}'.".format([key]))
	else:
		push_error("Requested scene '{0}' was not recognized... ignoring call for changing scene.".format([key]))

static func load_JSON(path : String) -> Dictionary:
# Load a JSON-file, convert it to a dictionary and return it.
	var file : File = File.new()
	var error : int = file.open(path, File.READ)
	if error == OK:
		var text : String = file.get_as_text()
		file.close()
		var parse_result = parse_json(text)
		if parse_result is Dictionary:
			return parse_result
		elif parse_result is Array:
			push_error("Top-level arrays in JSON are not allowed! (@ '{0}')".format([path]))
		else:
			push_error("Failed to correctly process '{0}', check file format!".format([path]))
		return {}
	else:
		push_error("Failed to open '{0}', check file availability!".format([path]))
		return {}

static func save_JSON(path : String, dictionary : Dictionary) -> int:
## Save a dictionary, in JSON format, to a file.
	var file : File = File.new()
	var error : int = file.open(path, File.WRITE)
	if error == OK:
		var text : String = to_json(dictionary)
		text = JSONBeautifier.beautify_json(text)
		file.store_string(text)
		file.close()

		print("Succesfully saved '{0}'.".format([path]))
		return OK
	else:
		push_error("Could not open file for writing purposes '{0}', check if file is locked!".format([path]))
		return error

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

static func build_INK(path : String) -> int:
## Compile an INK file at location path to a JSON file at the same location.
	var source_path: String = "{0}".format([path])
	var target_path: String = "{0}.json".format([path])
	var file : File = File.new()

	# Check if all necessary files/executables exist!
	if not file.file_exists(source_path):
		push_error("INK-file with path '{0}' did not exist! Aborting building function...".format([source_path]))
		return ERR_FILE_NOT_FOUND

	var output := []
	var inklecate_path = ""
	if OS.get_name() == "Windows" or OS.get_name() == "X11":
		inklecate_path = get_game_folder() + "/inklecate/inklecate.exe"
	else:
		push_error("Building INK files is not supported on platform '{0}'".format([OS.get_name()]))
		return ERR_COMPILATION_FAILED

	if not file.file_exists(inklecate_path):
		push_error("Failed to find Inklecate building tool '{0}', check path availability!".format([inklecate_path]))
		return ERR_FILE_NOT_FOUND

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

static func get_game_folder() -> String:
	if OS.has_feature("standalone"):
		print("Running an exported build.")
		return OS.get_executable_path().get_base_dir()
	else:
		print("Running from the editor.")
		return ProjectSettings.globalize_path("res://")
