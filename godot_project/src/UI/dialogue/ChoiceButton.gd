extends Button

signal choice_button_pressed

func _ready():
	var _error := connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	emit_signal("choice_button_pressed")
