extends Control

onready var _tyres_highlight := $VBoxContainer/BackgroundRect/Highlights/TyresHighlight
onready var _horn_highlight := $VBoxContainer/BackgroundRect/Highlights/HornHighlight
onready var _pedal_highlight := $VBoxContainer/BackgroundRect/Highlights/PedalHighlight
onready var _saddle_highlight := $VBoxContainer/BackgroundRect/Highlights/SaddleHighlight

onready var highlight_dict := {
	_tyres_highlight : {
		"name": "Tyres",
		"index" : 0
	},
	_horn_highlight : {
		"name": "Horn",
		"index" : 1
	},
	_pedal_highlight : {
		"name": "Pedal",
		"index" : 2
	},
	_saddle_highlight : {
		"name": "Saddle",
		"index" : 3
	}
}

func _ready():
	Flow.bike_repair_UI = self
	
	for key in highlight_dict.keys():
		key.connect("mouse_pressed", self, "_on_mouse_pressed")

func _on_mouse_pressed(highlight_rect : TextureRect):
	if highlight_dict.has(highlight_rect):
		var index : int = highlight_dict[highlight_rect].index
		print("pressed " + highlight_dict[highlight_rect].name)
