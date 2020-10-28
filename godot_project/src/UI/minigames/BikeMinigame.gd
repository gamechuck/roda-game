extends classMinigame

onready var _highlights_container := $VBoxContainer/BackgroundRect/Highlights

func _ready():
	for child in _highlights_container.get_children():
		if child is classHighlightRect:
			child.connect("mouse_pressed", self, "_on_mouse_pressed", [child])

func _on_mouse_pressed(component_rect : classHighlightRect):
	var index : int = component_rect.type
	if Director.is_waiting_for_choice:
		Director._on_choice_button_pressed(index)
	if ConfigData.verbose_mode : print("BIKE REPAIR - pressed {0}".format([component_rect.type]))
