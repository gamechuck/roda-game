extends TextureRect

onready var _area_2D := $Area2D

func _ready():
	var _error : int = _area_2D.connect("mouse_entered", self, "_on_mouse_entered")
	_error = _area_2D.connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	print("test")
	modulate.a = 1

func _on_mouse_exited():
	modulate.a = 0
