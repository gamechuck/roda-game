extends Control

#onready var _animation_player := $AnimationPlayer

onready var _label := $PanelContainer/Label

var _dialogue_array := []

func _ready():
	Flow.dialogue_UI = self

func start_dialogue(character : class_character):
	visible = true
	_dialogue_array.push_back("Bok, moj ime je Solid Snek.")
	_dialogue_array.push_back("Ja volim burek.")
	update_dialogue()

func update_dialogue() -> bool:
	if not _dialogue_array.empty():
		var text : String = _dialogue_array.pop_front()
		_label.text = text
		return true
	else:
		_stop_dialogue()
		return false

func _stop_dialogue():
	visible = false
