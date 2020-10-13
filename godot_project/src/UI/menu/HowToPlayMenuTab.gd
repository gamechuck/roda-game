extends classMenuTab

onready var _back_button := $VBoxContainer/BackButton

func _ready():
	var _error : int = _back_button.connect("pressed", self, "_on_back_button_pressed")
