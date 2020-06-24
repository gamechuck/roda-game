extends Control

onready var _hightlights_container := $VBoxContainer/BackgroundRect/Highlights

onready var _tyres_highlight := _hightlights_container.get_node("TyresHighlight")
onready var _pedal_highlight := _hightlights_container.get_node("PedalHighlight")
onready var _lights_highlight := _hightlights_container.get_node("LightsHighlight")
onready var _horn_highlight := _hightlights_container.get_node("HornHighlight")
onready var _saddle_highlight := _hightlights_container.get_node("SaddleHighlight")

onready var highlight_dict := {
	_tyres_highlight : {
		"name": "Tyres",
		"index" : 0
	},
	_pedal_highlight : {
		"name": "Pedal",
		"index" : 1
	},
	_lights_highlight : {
		"name": "Lights",
		"index" : 2
	},
	_horn_highlight : {
		"name": "Horn",
		"index" : 3
	},
	_saddle_highlight : {
		"name": "Saddle",
		"index" : 4
	}
}

func _ready():
	Flow.bike_repair_UI = self

	for key in highlight_dict.keys():
		key.connect("mouse_pressed", self, "_on_mouse_pressed")

func _on_mouse_pressed(highlight_rect : TextureRect):
	if highlight_dict.has(highlight_rect):
		var index : int = highlight_dict[highlight_rect].index
		if Flow.dialogue_UI.is_waiting_for_choice:
			Flow.player.is_in_dialogue = Flow.dialogue_UI.update_dialogue(index)
		print("pressed " + highlight_dict[highlight_rect].name)
