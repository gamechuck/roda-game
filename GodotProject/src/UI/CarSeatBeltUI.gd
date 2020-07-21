extends Control

onready var _hightlights_container := $VBoxContainer/BackgroundRect/Highlights
onready var _character_grid := $VBoxContainer/BackgroundRect/CarRect/CharacterGrid

onready var _drive_button := $VBoxContainer/HBoxContainer/DriveButton

onready var _seat1_highlight := _hightlights_container.get_node("Seat1")
onready var _seat2_highlight := _hightlights_container.get_node("Seat2")
onready var _seat3_highlight := _hightlights_container.get_node("Seat3")
onready var _seat4_highlight := _hightlights_container.get_node("Seat4")

onready var _adult_rect := _character_grid.get_node("Adult")
onready var _teenager_rect := _character_grid.get_node("Teenager")
onready var _child_rect := _character_grid.get_node("Child")
onready var _baby_rect := _character_grid.get_node("Baby")

var active_character : TextureRect = null

onready var highlight_dict := {
	_seat1_highlight : {
		"name": "Seat1",
		"correct_character" :  _adult_rect
	},
	_seat2_highlight : {
		"name": "Seat2",
		"correct_character" :  _child_rect
	},
	_seat3_highlight : {
		"name": "Seat3",
		"correct_character" :  _teenager_rect
	},
	_seat4_highlight : {
		"name": "Seat4",
		"correct_character" :  _baby_rect
	}
}

func _ready():
	Flow.car_seat_belt_UI = self

	var _error := _drive_button.connect("pressed", self, "on_drive_button_pressed")

	for key in highlight_dict.keys():
		key.connect("mouse_pressed", self, "_on_mouse_pressed")
	for child in _character_grid.get_children():
		if not child is class_character_slot:
			continue
		child.connect("button_pressed", self, "_on_character_pressed", [child])

func _on_mouse_pressed(highlight_rect : TextureRect) -> void:
	if highlight_dict.has(highlight_rect):
		if active_character and highlight_rect.character == null:
			active_character.pressed = false
			active_character.disabled = true
			highlight_rect.character = active_character

			active_character = null
		elif highlight_rect.character != null:
			var character : class_character_slot = highlight_rect.character
			character.disabled = false

			highlight_rect.character = null

func _on_character_pressed(pressed : bool, pressed_character :  class_character_slot) -> void:
	for child in _character_grid.get_children():
		if not child is class_character_slot:
			continue
		if child != pressed_character:
			child.pressed = false
		else:
			child.pressed = pressed
			if pressed:
				active_character = pressed_character
			else:
				active_character = null

func _on_drive_button_pressed():
	print("pressed drive button!")
