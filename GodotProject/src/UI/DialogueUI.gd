extends Control

onready var _label := $PanelContainer/Label
onready var _portrait_rect := $PortraitRect

var story : Object

func _ready():
	Flow.dialogue_UI = self

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

		var portrait_data : Dictionary = data.get("PORTRAIT", {})
		var texture_path : String = portrait_data.get("TEXTURE", Flow.FALLBACK_PORTRAIT_TEXTURE)
		var texture_exists : bool = ResourceLoader.exists(texture_path)
		print(texture_path)
		if not texture_exists:
			texture_path = Flow.FALLBACK_PORTRAIT_TEXTURE
		_portrait_rect.texture = load(texture_path)

		var portrait_size = portrait_data.get("SIZE", [200, 200])
		_portrait_rect.rect_min_size = Vector2(portrait_size[0], portrait_size[1])
		_portrait_rect.rect_size = _portrait_rect.rect_min_size
		var portrait_position = portrait_data.get("POSITION", [200, 30])
		_portrait_rect.rect_position = Vector2(portrait_position[0], portrait_position[1])

		_portrait_rect.flip_h = portrait_data.get("FLIP_H", false)
		_portrait_rect.flip_v = portrait_data.get("FLIP_V", false)
		
		_portrait_rect.visible = true

	elif node is class_item:
		data = Flow.get_item_data(node.name)

		_portrait_rect.visible = false

	var knot : String = data.get("KNOT", "")
	if story.knot_container_with_name(knot) != null:
		story.choose_path_string(knot)
		return update_dialogue()
	return false

func update_dialogue() -> bool:
	if story.can_continue:
		var text : String = story.continue()
		text = text.strip_edges()
		if not text.empty():
			_label.text = text.strip_edges()
			visible = true
			return true
		else:
			return update_dialogue()
	elif story.current_choices.size() > 0:
		story.choose_choice_index(0)
		return update_dialogue()
	else:
		_stop_dialogue()
		return false

func _stop_dialogue() -> void:
	visible = false
