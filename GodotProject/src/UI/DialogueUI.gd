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

func start_item_dialogue(character : class_character, item_id : String) -> bool:
	character.play_sound_byte()
	var character_id : String = character.name
	var character_data : Dictionary = Flow.get_character_data(character_id)
	var item_dialogues : Dictionary = character_data.get("item_dialogues", {})
	_dialogue_array = item_dialogues.get(item_id, [])
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
