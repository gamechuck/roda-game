tool
extends StaticBody2D
class_name class_pedestrian_light

onready var _animated_UI := $Node2D/AnimatedUI
onready var _animated_front := $AnimatedFront
onready var _animated_side := $AnimatedSide

export(String, "front", "left", "right") var direction = "front" setget set_direction
var light_color : int = Flow.LIGHT_COLOR.RED setget set_light_color

func _ready():
	set_direction(direction)
	set_light_color(light_color)

	update()

func set_direction(value : String):
	direction = value
	match value:
		"front":
			$Node2D/AnimatedUI.visible = false
			$AnimatedFront.visible = true
			$AnimatedSide.visible = false
		"left":
			$Node2D/AnimatedUI.visible = true
			$AnimatedFront.visible = false
			$AnimatedSide.visible = true

			$AnimatedSide.scale.x = 1
			$Node2D.scale.x = 1 
		"right":
			$Node2D/AnimatedUI.visible = true
			$AnimatedFront.visible = false
			$AnimatedSide.visible = true

			$AnimatedSide.scale.x = -1
			$Node2D.scale.x = -1 

func set_light_color(value : int):
	light_color = value
	match light_color:
		Flow.LIGHT_COLOR.RED,Flow.LIGHT_COLOR.YELLOW_AFTER_RED, Flow.LIGHT_COLOR.YELLOW_AFTER_GREEN:
			play_animation("red")
		Flow.LIGHT_COLOR.GREEN:
			play_animation("green")

func play_animation(animation_name : String):
	_animated_UI.play(animation_name)
	_animated_front.play(animation_name)
	_animated_side.play(animation_name)
