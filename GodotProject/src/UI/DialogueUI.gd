extends Control

#onready var _animation_player := $AnimationPlayer

onready var _label := $PanelContainer/Label

var _dialogue_array := []

func _ready():
	Flow.dialogue_UI = self

func start_dialogue(character : class_character) -> bool:
	character.play_sound_byte()
	var character_id : String = character.name
	var character_data : Dictionary = Flow.get_character_data(character_id)
	_dialogue_array = character_data.get("dialogue_text", [])
	return update_dialogue()

func start_use_item_dialogue(node : Node2D, item_id : String) -> bool:
	var data := {}
	if node is class_character:
		node.play_sound_byte()
		data = Flow.get_character_data(node.name)
	elif node is class_item:
		data = Flow.get_item_data(node.name)
	var use_item : Dictionary = data.get("use_item", {})
	var item_dictionary : Dictionary = use_item.get(item_id, {})
	_dialogue_array = item_dictionary.get("dialogue_text", [])
	return update_dialogue()

func start_pickup_dialogue(item : class_item) -> bool:
	var item_id : String = item.name
	var item_data : Dictionary = Flow.get_item_data(item_id)
	var pickup_data : Dictionary = item_data.get("pickup", {})
	_dialogue_array = pickup_data.get("success_text", [])
	return update_dialogue()

func update_dialogue() -> bool:
	if not _dialogue_array.empty():
		var text : String = _dialogue_array.pop_front()
		_label.text = text
		visible = true
		return true
	else:
		_stop_dialogue()
		return false

func _stop_dialogue() -> void:
	visible = false
