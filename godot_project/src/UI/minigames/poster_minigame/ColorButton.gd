tool
extends Button

export(Color) var color setget set_bg_color, get_bg_color
func set_bg_color(value : Color) -> void:
	color = value
	$ColorRect.color = value
func get_bg_color() -> Color:
	return color
