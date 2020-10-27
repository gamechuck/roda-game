extends Control

# Ideally two thing would have to change drastically here:
# 1. Not allowing the user to add/select characters nor push the drive button when not waiting for a choice!
# 2. Change everything to be derived from control vs the current mix that is currently implemented!

enum PHASE {SEAT_SORTING = 0, BELTING = 1, ENDING = 2}
var _phase : int = PHASE.SEAT_SORTING

onready var _drive_button := $VBoxContainer/DriveButton

onready var _highlights_container := $VBoxContainer/HBoxContainer/BackgroundRect/Highlights

onready var _vbox_left := $VBoxContainer/HBoxContainer/VBoxLeft
onready var _teenager := _vbox_left.get_node("Teenager")
onready var _adult := _vbox_left.get_node("Adult")

onready var _vbox_right := $VBoxContainer/HBoxContainer/VBoxRight
onready var _baby := _vbox_right.get_node("Baby")
onready var _child := _vbox_right.get_node("Child")

onready var _characters_array := [_adult, _teenager, _child, _baby]

var active_character : classCharacterSlot = null

signal drive_button_pressed

func _ready():
	Flow.seat_sorting_UI = self

	var _error := _drive_button.connect("pressed", self, "_on_drive_button_pressed")
	_error = connect("drive_button_pressed", Director, "_on_choice_button_pressed")

	for child in _highlights_container.get_children():
		if child is classHighlightRect:
			child.connect("mouse_pressed", self, "_on_mouse_pressed", [child])

	for child in _characters_array:
		if child is classCharacterSlot:
			child.connect("button_pressed", self, "_on_character_pressed", [child])

func show():
	visible = true

func hide():
	visible = false

func clear_all_characters():
	for child in _highlights_container.get_children():
		if child is classHighlightRect:
			if child.character != null:
				var character : classCharacterSlot = child.character
				character.disabled = false

				child.character = null

func _on_mouse_pressed(seat_rect : classHighlightRect) -> void:
	match _phase:
		PHASE.SEAT_SORTING:
			if active_character and seat_rect.character == null:
				active_character.pressed = false
				active_character.disabled = true
				seat_rect.character = active_character

				active_character = null
			elif seat_rect.character != null:
				var character : classCharacterSlot = seat_rect.character
				character.disabled = false

				seat_rect.character = null
		PHASE.BELTING:
			seat_rect.is_belted = not seat_rect.is_belted

func _on_character_pressed(pressed : bool, pressed_character :  classCharacterSlot) -> void:
	match _phase:
		PHASE.SEAT_SORTING:
			for child in [_adult, _teenager, _child, _baby]:
				if child is classCharacterSlot:
					if child != pressed_character:
						child.pressed = false
					else:
						child.pressed = pressed
						if pressed:
							active_character = pressed_character
						else:
							active_character = null
		_:
			#You can't press any character buttons during belting and ending!!
			return

func _on_drive_button_pressed():
	match _phase:
		PHASE.SEAT_SORTING:
			for child in _highlights_container.get_children():
				if child is classHighlightRect:
					if not child.is_valid_character:
						if ConfigData.verbose_mode : print("SEAT SORTING - arrangement is incorrect!")
						if Director.is_waiting_for_choice:
							emit_signal("drive_button_pressed", 0)
						clear_all_characters()
						return

			if ConfigData.verbose_mode : print("SEAT SORTING - arrangement is correct!")
			emit_signal("drive_button_pressed", 1)
			_phase = PHASE.BELTING
		PHASE.BELTING:
			for child in _highlights_container.get_children():
				if child is classHighlightRect:
					if not child.is_belted:
						if ConfigData.verbose_mode : print("BELTING - someone is not wearing their belt!")
						if Director.is_waiting_for_choice:
							emit_signal("drive_button_pressed", 0)
						return

			if ConfigData.verbose_mode : print("BELTING - everyone is wearing their belt!")
			emit_signal("drive_button_pressed", 1)
			_phase = PHASE.ENDING
