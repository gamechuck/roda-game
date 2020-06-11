extends TextureRect

func _ready():
	var _error : int = connect("mouse_entered", self, "_on_mouse_entered")
	_error = connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	modulate.a = 1

func _on_mouse_exited():
	modulate.a = 0
