extends Control

onready var _choice_vbox := $VBoxContainer/ChoiceVBox
onready var _portrait_rect := $PortraitRect
onready var _portrait_spacer := $VBoxContainer/DialogueVBox/PanelContainer/HBoxContainer/PortraitSpacer

onready var _interact_timer := $InteractTimer

onready var _name_label := $VBoxContainer/DialogueVBox/NameLabel
onready var _dialogue_label := $VBoxContainer/DialogueVBox/PanelContainer/HBoxContainer/DialogueLabel

signal dialogue_updated

var _is_interaction_enabled := true

func _ready():
	Flow.dialogue_UI = self
	var _error := _interact_timer.connect("timeout", self, "_on_interact_timer_timeout")

	_error = connect("dialogue_updated", Director, "_on_dialogue_updated")

	var index := 0
	for child in _choice_vbox.get_children():
		child.connect("choice_button_pressed", Director, "_on_choice_button_pressed", [index])
		index += 1

	_choice_vbox.visible = false
	set_process_input(false)

func show():
	# Derive the state from the Director and update the UI as a result!
	var node = Director.interact_node
	if node is class_pickup:
		update_pickup_UI(node.state)
	elif node is class_character:
		update_character_UI(node.state)

	visible = true
	set_process_input(true)

func hide():
	visible = false
	set_process_input(false)

func update_pickup_UI(_pickup : class_pickup_state) -> void:
	_name_label.visible = false
	_portrait_spacer.visible = false
	_portrait_rect.visible = false

func update_character_UI(character : class_character_state) -> void:
	_portrait_rect.texture = character.portrait_texture

	_name_label.text = character.name
	_name_label.visible = true

	if _portrait_rect.texture:
		var portrait_size := character.portrait_size
		_portrait_rect.rect_min_size = portrait_size
		_portrait_rect.rect_size = portrait_size
		var portrait_position = character.portrait_position
		_portrait_rect.rect_position = portrait_position

		_portrait_rect.flip_h = character.flip_h
		_portrait_rect.flip_v = character.flip_v

		_portrait_spacer.visible = true
		_portrait_rect.visible = true
	else:
		_portrait_spacer.visible = false
		_portrait_rect.visible = false

func update_dialogue(text : String) -> void:
	_choice_vbox.visible = false
	_portrait_rect.self_modulate.a = 1.0

	_dialogue_label.text = text

func update_multiple_choice(choices : Array) -> void:
	_choice_vbox.visible = true
	_portrait_rect.self_modulate.a = 0.5

	var index := 0
	for child in _choice_vbox.get_children():
		if index < choices.size():
			child.text = choices[index]
			child.visible = true
		else:
			child.visible = false
		index += 1

func _input(event):
	if not _is_interaction_enabled:
		return

	if event.is_action_pressed("interact"):
		Flow.active_character = null
		Flow.active_item = null
		emit_signal("dialogue_updated")
		start_interact_timeout()
		get_tree().set_input_as_handled()
	if event.is_action_released("left_mouse_button"):
		Flow.active_character = null
		Flow.active_item = null
		emit_signal("dialogue_updated")
		start_interact_timeout()
		if Director.active_minigame != null:
			return
		elif Director.is_waiting_for_choice:
			return

		get_tree().set_input_as_handled()

func start_interact_timeout():
## Start an interaction timeout so the player doesn't interact accidentely.
	_is_interaction_enabled = false
	_interact_timer.start()

func _on_interact_timer_timeout():
## Re-enable interaction...
	_is_interaction_enabled = true
