tool
extends StaticBody2D
class_name class_traffic_light

onready var _animated_UI := $Node2D/AnimatedUI
onready var _animated_front := $AnimatedFront
onready var _animated_back := $AnimatedBack
onready var _animated_side := $AnimatedSide

export(String, "front", "left", "right", "back") var direction = "front" setget set_direction
var light_color : int = ConfigData.LIGHT_COLOR.RED setget set_light_color

func _ready():
	set_direction(direction)
	set_light_color(light_color)

func set_direction(value : String):
	direction = value
	var state = animation_state.get(value, "front")

	$Node2D/AnimatedUI.visible = state.get("visible_UI", false) 
	$AnimatedFront.visible = state.get("visible_front", true) 
	$AnimatedSide.visible = state.get("visible_side", false)
	$AnimatedBack.visible = state.get("visible_back", false) 

	$AnimatedSide.scale.x = state.get("scale", 1) 
	$Node2D.scale.x = state.get("scale", 1) 

func set_light_color(value : int):
	light_color = value
	match light_color:
		ConfigData.LIGHT_COLOR.RED:
			play_animation("red")
		ConfigData.LIGHT_COLOR.YELLOW_AFTER_RED, ConfigData.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			play_animation("yellow")
		ConfigData.LIGHT_COLOR.GREEN:
			play_animation("green")

func play_animation(animation_name : String):
	_animated_UI.play(animation_name)
	_animated_front.play(animation_name)
	_animated_side.play(animation_name)

var animation_state := {
	"left": {
		"visible_UI": true,
		"scale": -1,
		"visible_side": true,
		"visible_front": false,
		"visible_back": false
	},
	"front": {
		"visible_UI": false,
		"visible_side": false,
		"visible_front": true,
		"visible_back": false
	},
	"right": {
		"visible_UI": true,
		"scale": 1,
		"visible_side": true,
		"visible_front": false,
		"visible_back": false
	},
	"back": {
		"visible_UI": true,
		"visible_side": false,
		"visible_front": false,
		"visible_back": true
	}
}
