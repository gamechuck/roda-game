extends classMenuTab

onready var _back_button := $BackHBox/BackButton

func _ready():
	var _error : int = _back_button.connect("pressed", self, "_on_back_button_pressed")

	for child in $SelectHBox.get_children():
		_error = child.connect("start_button_pressed", self, "_on_start_button_pressed", [child.number])

func update_tab():
	_back_button.grab_focus()

func _on_start_button_pressed(level_number : int):
	Flow.level_number = level_number
	Flow.change_scene_to("game")
