extends TextureRect

onready var _area_2D := $Area2D

var is_mouse_inside := false

func _ready():
	var _error : int = _area_2D.connect("mouse_entered", self, "_on_mouse_entered")
	_error = _area_2D.connect("mouse_exited", self, "_on_mouse_exited")
	
	modulate.a = 0

func _on_mouse_entered():
	is_mouse_inside = true
	modulate.a = 1

func _on_mouse_exited():
	is_mouse_inside = false
	modulate.a = 0
