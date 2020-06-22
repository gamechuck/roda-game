extends Control

onready var _label := $VBoxContainer/PanelContainer/Label
onready var _portrait_rect := $PortraitRect

onready var _name_label := $VBoxContainer/NameLabel
onready var _choice_vbox := $VBoxContainer/ChoiceVBox

var story : Object
var is_waiting_for_choice := false

func _ready():
	Flow.dialogue_UI = self

	var index := 0
	for child in _choice_vbox.get_children():
		child.connect("choice_button_pressed", self, "update_dialogue", [index])
		index += 1
	
	_choice_vbox.visible = false

func start_interact_dialogue(node : Node2D) -> bool:
	story.variables_state.set("conv_type", 0)
	return _start_dialogue(node)

func start_use_item_dialogue(node : Node2D, item_id : String) -> bool:
	story.variables_state.set("used_item", item_id)
	story.variables_state.set("conv_type", 1)
	return _start_dialogue(node)

func _start_dialogue(node : Node2D) -> bool:
	var data := {}
	if node is class_character:
		node.play_sound_byte()
		data = Flow.get_character_data(node.name)

		_name_label.text = data.get("DISPLAY_NAME", "")

		var portrait_data : Dictionary = data.get("PORTRAIT", {})
		var texture_path : String = portrait_data.get("TEXTURE", "")
		var texture_exists : bool = ResourceLoader.exists(texture_path)
		if texture_exists:
			_portrait_rect.texture = load(texture_path)
		else:
			_portrait_rect.texture = null

		var portrait_size = portrait_data.get("SIZE", [200, 200])
		_portrait_rect.rect_min_size = Vector2(portrait_size[0], portrait_size[1])
		_portrait_rect.rect_size = _portrait_rect.rect_min_size
		var portrait_position = portrait_data.get("POSITION", [200, 30])
		_portrait_rect.rect_position = Vector2(portrait_position[0], portrait_position[1])

		_portrait_rect.flip_h = portrait_data.get("FLIP_H", false)
		_portrait_rect.flip_v = portrait_data.get("FLIP_V", false)

		_name_label.visible = true
		_portrait_rect.visible = true

	elif node is class_item:
		data = Flow.get_item_data(node.name)

		_name_label.visible = false
		_portrait_rect.visible = false

	var knot : String = data.get("KNOT", "")
	if story.knot_container_with_name(knot) != null:
		story.choose_path_string(knot)
		return update_dialogue()
	return false

func update_dialogue(choice_index : int = -1) -> bool:
	if is_waiting_for_choice:
		if choice_index != -1 and choice_index < story.current_choices.size():
			story.choose_choice_index(choice_index)
			is_waiting_for_choice = false
			return update_dialogue()
		else:
			return true

	if story.can_continue:
		_choice_vbox.visible = false
		_portrait_rect.self_modulate.a = 1.0

		var text : String = story.continue()
		text = text.strip_edges()
		print(text)
		if text.left(3) == ">>>":
			# It's some sort of command! Give it to the Director!
			Director.execute_command(text)
			return update_dialogue()

		if not text.empty():
			_label.text = text.strip_edges()
			visible = true
			return true
		else:
			return update_dialogue()
	elif story.current_choices.size() > 0:
		is_waiting_for_choice = true

		if Director.active_minigame == null:
			_choice_vbox.visible = true
			_portrait_rect.self_modulate.a = 0.5
	
			var index := 0
			for child in _choice_vbox.get_children():
				if index < story.current_choices.size():
					var choice = story.current_choices[index]
					child.text = choice.text
					child.visible = true
				else:
					child.visible = false
				index += 1

		#story.choose_choice_index(0)
		return true
	else:
		_stop_dialogue()
		return false

func _stop_dialogue() -> void:
	visible = false
