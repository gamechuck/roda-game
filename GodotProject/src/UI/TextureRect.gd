extends TextureRect

func _ready():
	$TextureButton.connect("mouse_entered", self, "_on_button_pressed")
	
func _on_mouse_entered():
	print("ENTER")
