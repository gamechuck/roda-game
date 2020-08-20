tool
extends Node

signal version_visibility_changed()

## ENUM & CONSTANTS  ###########################################################
enum LIGHT_COLOR {RED, YELLOW_AFTER_RED, GREEN, YELLOW_AFTER_GREEN}

## VERSION CONFIG ##############################################################
var major_version := 0
var minor_version := 0

## AUDIO SETTINGS ##############################################################
var master_volume := 100.0 setget set_master_volume

## GRAPHICS SETTINGS ###########################################################
var show_version := true setget set_show_version

## SETTINGS ###########################################################
var locale := "hr" setget set_locale

## COMMON CONFIG #################################################################
var verbose_mode := true
var skip_menu := true

## GAME CONFIG #################################################################
var skater_move_speed := 4.0

var ghost_awake_move_speed := 1.0
var ghost_sleeping_move_speed := 0.1
var ghost_activation_distance := 200

var player_move_speed := 2.0
var gummy_modifier := 0.5
var bike_modifier := 2.0
var minimum_interaction_distance := 200

var traffic_red_time := 10.0
var traffic_yellow_after_red_time := 0.5
var traffic_yellow_after_green_time := 0.5
var traffic_green_time := 10.0

var boss_max_health := 100.0

var bullet_speed := 200
var bullet_ttl := 2

var tracking_speed := 50
var tracking_ttl := 4

var whirling_speed := 1
var whirling_ttl := 10

var car_move_speed := 4.0
var panic_modifier := 2.0

func set_master_volume(value : float):
	master_volume = value
	var volume_db : float = 20*log(float(value)/100.0)/log(10.0)
	# -INF (when new_value = 0) doesn't seem to pose any issues!
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

func set_show_version(value : bool):
	show_version = value
	emit_signal("version_visibility_changed")

func set_locale(value : String):
	if value in TranslationServer.get_loaded_locales():
		locale = value
		TranslationServer.set_locale(locale)
