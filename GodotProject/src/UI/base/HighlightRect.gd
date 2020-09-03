extends TextureRect
class_name class_highlight_rect

onready var _area_2D := $Area2D

var is_mouse_inside := false

signal mouse_pressed

func _ready():
	var _error : int = _area_2D.connect("mouse_entered", self, "_on_mouse_entered")
	_error = _area_2D.connect("mouse_exited", self, "_on_mouse_exited")
	_error = _area_2D.connect("input_event", self, "_on_input_event")

	self_modulate.a = 0

func _on_mouse_entered():
	is_mouse_inside = true
	self_modulate.a = 1

func _on_mouse_exited():
	is_mouse_inside = false
	self_modulate.a = 0

func _on_input_event(_viewport, event, _shape_idx):
	if is_mouse_inside and event.is_action_released("left_mouse_button"):
		emit_signal("mouse_pressed")
