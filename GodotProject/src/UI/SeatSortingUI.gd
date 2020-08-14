extends Control

onready var _drive_button := $VBoxContainer/DriveButton

onready var _highlights_container := $VBoxContainer/HBoxContainer/BackgroundRect/Highlights

onready var _vbox_left := $VBoxContainer/HBoxContainer/VBoxLeft
onready var _teenager := _vbox_left.get_node("Teenager")
onready var _adult := _vbox_left.get_node("Adult")

onready var _vbox_right := $VBoxContainer/HBoxContainer/VBoxRight
onready var _baby := _vbox_right.get_node("Baby")
onready var _child := _vbox_right.get_node("Child")

onready var _characters_array := [_adult, _teenager, _child, _baby]

var active_character : class_character_slot = null

func _ready():
	Flow.seat_sorting_UI = self

	var _error := _drive_button.connect("pressed", self, "_on_drive_button_pressed")

	for child in _highlights_container.get_children():
		if child is class_highlight_rect:
			child.connect("mouse_pressed", self, "_on_mouse_pressed", [child])

	for child in _characters_array:
		if child is class_character_slot:
			child.connect("button_pressed", self, "_on_character_pressed", [child])

func show():
	visible = true

func hide():
	visible = false

func reset_all():
	if Flow.dialogue_UI.is_waiting_for_choice:
		Flow.player.is_in_dialogue = Flow.dialogue_UI.update_dialogue(0)
	
	for child in _highlights_container.get_children():
		if child is class_highlight_rect:
			if child.character != null:
				var character : class_character_slot = child.character
				character.disabled = false
	
				child.character = null

func _on_mouse_pressed(seat_rect : class_highlight_rect) -> void:
	if active_character and seat_rect.character == null:
		active_character.pressed = false
		active_character.disabled = true
		seat_rect.character = active_character

		active_character = null
	elif seat_rect.character != null:
		var character : class_character_slot = seat_rect.character
		character.disabled = false

		seat_rect.character = null

func _on_character_pressed(pressed : bool, pressed_character :  class_character_slot) -> void:
	for child in [_adult, _teenager, _child, _baby]:
		if child is class_character_slot:
			if child != pressed_character:
				child.pressed = false
			else:
				child.pressed = pressed
				if pressed:
					active_character = pressed_character
				else:
					active_character = null

func _on_drive_button_pressed():
	for child in _highlights_container.get_children():
		if child is class_highlight_rect:
			if not child.is_valid_character:
				if ConfigData.verbose_mode : print("SEAT SORTING - arrangement is incorrect!")
				if Flow.dialogue_UI.is_waiting_for_choice:
					Flow.player.is_in_dialogue = Flow.dialogue_UI.update_dialogue(0)
				reset_all()
				return

	if ConfigData.verbose_mode : print("SEAT SORTING - arrangement is correct!")
	if Flow.dialogue_UI.is_waiting_for_choice:
		Flow.player.is_in_dialogue = Flow.dialogue_UI.update_dialogue(1)
