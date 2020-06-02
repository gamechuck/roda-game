extends StaticBody2D
class_name class_traffic_light

onready var _animated_sprite := $AnimatedSprite

var light_color : int = Flow.LIGHT_COLOR.RED setget set_light_color

func set_light_color(value : int):
	light_color = value
	match light_color:
		Flow.LIGHT_COLOR.RED:
			_animated_sprite.play("red")
		Flow.LIGHT_COLOR.YELLOW:
			_animated_sprite.play("yellow")
		Flow.LIGHT_COLOR.GREEN:
			_animated_sprite.play("green")
