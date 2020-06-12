extends TextureRect

onready var _area_2D := $Area2D

var is_mouse_inside := false

signal mouse_pressed

func _ready():
	var _error : int = _area_2D.connect("mouse_entered", self, "_on_mouse_entered")
	_error = _area_2D.connect("mouse_exited", self, "_on_mouse_exited")
	_error = _area_2D.connect("input_event", self, "_on_input_event")
	
	modulate.a = 0

func _on_mouse_entered():
	is_mouse_inside = true
	modulate.a = 1

func _on_mouse_exited():
	is_mouse_inside = false
	modulate.a = 0

func _on_input_event(_viewport, event, _shape_idx):
	if not is_mouse_inside:
		return

	if event.is_action_pressed("left_mouse_button"):
		emit_signal("mouse_pressed", self)
