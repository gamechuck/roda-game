# This script loads and manages all settings and options as saved in default_options.cfg
# and user_settings.cfg (if available).
# Custom setter/getters should be defined whenever required!
extends Node

signal version_visibility_changed

func load_optionsCFG() -> int:
	## Load the game and editor options and settings from both the default and the user-modified one.
	var config : ConfigFile = ConfigFile.new()
	var file : File = File.new()
	var error : int = config.load(Flow.DEFAULT_OPTIONS_PATH)
	if error == OK: # if not, something went wrong with the file loading.
		error = _parse_config(config)
		print("Succesfully loaded and processed '{0}'.".format([Flow.DEFAULT_OPTIONS_PATH]))
		# Check if there are any user-modified options that need to be overwritten.
		if file.file_exists(Flow.USER_SETTINGS_PATH):
			print("Attempting to load user-modified settings from '{0}'.".format([Flow.USER_SETTINGS_PATH]))
			error = config.load(Flow.USER_SETTINGS_PATH)
			if error == OK: # if not, something went wrong with the file loading.
				error = _parse_config(config)
				print("Succesfully loaded and processed '{0}'.".format([Flow.USER_SETTINGS_PATH]))
				return OK
			else:
				push_error("Failed to load '{0}', check file format!".format([Flow.DEFAULT_OPTIONS_PATH]))
				return error
		else:
			return OK
	else:
		push_error("Failed to open '{0}', check file availability!".format([Flow.DEFAULT_OPTIONS_PATH]))
		return error

func reset_optionsCFG() -> int:
	## Load the default options without checking for any previously saved user_settings
	## This basically resets the user_settings since they will be overwritten!
	var config : ConfigFile = ConfigFile.new()
	var error : int = config.load(Flow.DEFAULT_OPTIONS_PATH)
	if error == OK: # if not, something went wrong with the file loading.
		error = _parse_config(config)
		print("Succesfully re-loaded and processed '{0}'.".format([Flow.DEFAULT_OPTIONS_PATH]))
		return OK
	else:
		push_error("Failed to open '{0}', check file availability!".format([Flow.DEFAULT_OPTIONS_PATH]))
		return error

func save_settingsCFG() -> int:
	## Save settings that can be user-modified to a configuration file.
	var config : ConfigFile = ConfigFile.new()
	var error : int = config.load(Flow.DEFAULT_OPTIONS_PATH)
	if error == OK: # if not, something went wrong with the file loading.
		for section_id in config.get_sections():
			# Only save the sections that begin with "settings"!
			if section_id.begins_with("settings"):
				for key in config.get_section_keys(section_id):
					if ConfigData.get(key) != null:
						config.set_value(section_id, key, ConfigData.get(key))
					else:
						push_error("Failed to set configuration property {0}!".format([key]))
			else: # Erase the section, since it doesnt pertain to any user-modifiable settings!
				config.erase_section(section_id)
		return _synchronize_user_settings(config)
	else:
		push_error("Failed to open '{0}', check file availability!".format([Flow.DEFAULT_OPTIONS_PATH]))
		return error

func _synchronize_user_settings(config : ConfigFile) -> int:
	## Check if 'user_settings.cfg' already exists and only overwrite settings.
	# Thus leaving any custom dev options alone.
	var old_config : ConfigFile = ConfigFile.new()
	var error : int = old_config.load(Flow.USER_SETTINGS_PATH)
	if  error == OK:
		for section_id in config.get_sections():
			for key in config.get_section_keys(section_id):
				old_config.set_value(section_id, key, ConfigData.get(key))

	return old_config.save(Flow.USER_SETTINGS_PATH)

func _parse_config(config : ConfigFile) -> int:
	## Load all configuration variables to the ConfigData autoload script.
	for section_id in config.get_sections():
		for key in config.get_section_keys(section_id):
			if ConfigData.get(key) != null:
				ConfigData.set(key, config.get_value(section_id, key, ConfigData.get(key)))
			else:
				push_error("Failed to set configuration property {0}!".format([key]))
	return OK

## ENUM & CONSTANTS  ###########################################################
enum LIGHT_COLOR {RED, YELLOW_AFTER_RED, GREEN, YELLOW_AFTER_GREEN}

## VERSION CONFIG ##############################################################
var major_version := 0
var minor_version := 0

## AUDIO SETTINGS ##############################################################
var master_volume := 100.0 setget set_master_volume
func set_master_volume(value : float):
	master_volume = value
	var volume_db : float = 20*log(float(value)/100.0)/log(10.0)
	# -INF (when new_value = 0) doesn't seem to pose any issues!
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

## GRAPHICS SETTINGS ###########################################################
var show_version := true setget set_show_version
func set_show_version(value : bool):
	show_version = value
	emit_signal("version_visibility_changed")

var fullscreen := false setget set_fullscreen
func set_fullscreen(value : bool):
	fullscreen = value
	OS.window_fullscreen = value

## SETTINGS ####################################################################
var locale := "hr" setget set_locale
func set_locale(value : String):
	if value in TranslationServer.get_loaded_locales():
		locale = value
		TranslationServer.set_locale(locale)

## COMMON CONFIG ###############################################################
var verbose_mode := true
var skip_menu := true

## GAME CONFIG #################################################################
var skip_intro := true

var skater_move_speed := 4.0

var ghost_awake_move_speed := 1.0
var ghost_sleeping_move_speed := 0.1
var ghost_activation_distance := 200

var player_move_speed := 2.0
var gummy_modifier := 0.5
var bike_modifier := 2.0
var minimum_interaction_distance := 200

var wheelie_move_speed := 1.5

var traffic_red_time := 10.0
var traffic_yellow_after_red_time := 0.5
var traffic_yellow_after_green_time := 0.5
var traffic_green_time := 10.0

var boss_max_health := 100.0

var bullet_speed := 200
var bullet_ttl := 4

var tracking_speed := 50
var tracking_ttl := 4

var whirling_speed := 1
var whirling_ttl := 10

var car_move_speed := 4.0
var panic_modifier := 2.0
