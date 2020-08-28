extends Node

onready var _tween := $Tween

var story : Object
var interact_node : Node2D = null
var active_minigame : Control = null

var is_waiting_for_choice := false
var dialogue_in_progress := false

signal dialogue_ended()
signal cutscene_ended()

func _on_dialogue_started(node : Node2D, item_id : String = ""):
	if item_id.empty():
		story.variables_state.set("interact_id", node.state.id)
		story.variables_state.set("conv_type", 0)
	else:
		story.variables_state.set("interact_id", node.state.id)
		story.variables_state.set("used_item", item_id)
		story.variables_state.set("conv_type", 1)
	interact_node = node
	dialogue_in_progress = _start_dialogue()

#func start_knot_dialogue(knot : String) -> bool:
#	story.variables_state.set("conv_type", 0)
#	interact_node = null
#
#	if story.knot_container_with_name(knot) != null:
#		story.choose_path_string(knot)
#		return update_dialogue()
#	else:
#		push_error("Could not find knot '{0}' in compiled INK-file.".format([knot]))
#		return false

func _start_dialogue() -> bool:
	var state : Reference
	var knot := ""
	if interact_node is class_character:
		interact_node.play_sound_byte()
		state = interact_node.state

	elif interact_node is class_pickup:
		state = interact_node.state

	if state:
		knot = state.knot

	if story.knot_container_with_name(knot) != null:
		story.choose_path_string(knot)
		return update_dialogue()
	else:
		push_error("Could not find knot '{0}' in compiled INK-file.".format([knot]))
		_stop_dialogue()
		return false

func _on_dialogue_updated() -> void:
	dialogue_in_progress = update_dialogue()

func _on_choice_button_pressed(choice_index : int = -1) -> void: 
	dialogue_in_progress = update_dialogue(choice_index)

func update_dialogue(choice_index : int = -1) -> bool:
	if is_waiting_for_choice:
		if choice_index != -1 and choice_index < story.current_choices.size():
			story.choose_choice_index(choice_index)
			is_waiting_for_choice = false
			return update_dialogue()
		else:
			return true

	if story.can_continue:
		var text : String = story.continue()
		text = text.strip_edges()
		print(text)
		if text.left(3) == ">>>":
			# It's some sort of command! Give it to the Director!
			var can_continue := execute_command(text)
			if can_continue:
				return update_dialogue()
			else:
				return true

		if not text.empty():
			# Attempt a translation!
			text = translate(text.strip_edges())
			Flow.dialogue_UI.update_dialogue(text)
			Flow.dialogue_UI.show()
			return true
		else:
			return update_dialogue()
	elif story.current_choices.size() > 0:
		is_waiting_for_choice = true

		if Director.active_minigame == null:
			var choices := []
			for choice in story.current_choices:
				var text : String = translate(choice.text)
				choices.append(text)
			Flow.dialogue_UI.update_multiple_choice(choices)

		#story.choose_choice_index(0)
		return true
	else:
		_stop_dialogue()
		return false

func _stop_dialogue() -> void:
	Flow.dialogue_UI.hide()
	emit_signal("dialogue_ended")

func get_state_property(character_id : String, property : String) -> int:
	var character : class_character_state = State.get_character_by_id(character_id)
	if character:
		var properties : Dictionary = character.properties
		return properties.get(property, 0)
	return 0

func set_state_property(argument_values : Array) -> void:
	var character_id : String = argument_values[0]
	var key : String = argument_values[1]
	var value : int = argument_values[2]

	var character : class_character_state = State.get_character_by_id(character_id)
	if character:
		var properties : Dictionary = character.properties
		if properties.has(key):
			properties[key] = value
			character.object.update_animation()
		else:
			push_error("State property '{0}' is not registered in the character's state!".format([key]))

func translate(original_text : String):
	var tags : Array = story.current_tags
	if tags.empty():
		return original_text
	else:
		var msg_id : String = tags[0]
		var translated_text : String = TranslationServer.translate(msg_id)
		if translated_text != msg_id:
			return translated_text
		else:
			return original_text

### PARSING COMMANDS
func _parse_command(raw_text : String) -> Dictionary:
## Parse the command (denoted by >>> in INK) and return as a dictionary.
	var processed_text := raw_text.replace(">>>", "").strip_edges()
	var split_text := processed_text.split(":")

	var command_dict := {}
	command_dict.name = split_text[0].strip_edges()
	command_dict.argument_values = []
	if split_text.size() > 1:
		var argument_values := split_text[1].split(" ", false)
		for value in argument_values:
			command_dict.argument_values.append(value.strip_edges())

	return command_dict

func execute_command(raw_text : String) -> bool:

	var command_dict := _parse_command(raw_text) 
	
	var argument_values : Array = command_dict.argument_values
	var external_dict : Dictionary = external_setters.get(command_dict.name, {})
	var argument_types : Array = external_dict.get("argument_types", [])
	var variable_number_of_arguments : bool = external_dict.get("variable_number_of_arguments", false)
	if not external_dict.empty():
		if argument_types.size() != argument_values.size() and not variable_number_of_arguments:
			push_error("Number of arguments of external setter function '{0}' was incorrect! Requires {1} arguments!".format([command_dict.name, argument_types.size()]))
			return true

		var argument_type : int = TYPE_MAX
		if variable_number_of_arguments:
			argument_type = argument_types[0]

		for index in range(0, argument_values.size()):
			if not variable_number_of_arguments:
				argument_type = argument_types[index]
			match argument_type:
				TYPE_STRING:
					argument_values[index] = String(argument_values[index])
				TYPE_BOOL:
					argument_values[index] = bool(argument_values[index])
				TYPE_INT:
					argument_values[index] = int(argument_values[index])

		var callback : FuncRef = external_dict.callback
		callback.call_func(argument_values)

	if command_dict.name == "PLAY_CUTSCENE":
		return false
	else:
		return true

func pan_camera(argument_values : Array):
	var mask : String = argument_values[0]
	var target_object = get_tree().root.find_node(mask, true, false)
	var game_camera : Camera2D = Flow.player.get_node("GameCamera")
	if target_object != null:
		var target_position : Vector2 = target_object.position
		target_position -= Flow.player.position

		_tween.interpolate_property(game_camera, "position", game_camera.position, target_position, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		_tween.start()

func zoom_camera(target_zoom : Vector2):
	var game_camera : Camera2D = Flow.player.get_node("GameCamera")

	_tween.interpolate_property(game_camera, "zoom", game_camera.zoom, target_zoom, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.start()

func add_item(argument_values):
	var item_id : String = argument_values[0]
	Flow.inventory.add_item_by_id(item_id)

func remove_item(argument_values):
	var item_id : String = argument_values[0]
	Flow.inventory.remove_item_by_id(item_id)

func show(argument_values):
	var mask : String = argument_values[0]
	var target_object = get_tree().root.find_node(mask, true, false)
	if target_object != null:
		target_object.visible = true
		target_object.set("collision_layer", 1)

func hide(argument_values):
	var mask : String = argument_values[0]
	var target_object = get_tree().root.find_node(mask, true, false)
	if target_object != null:
		target_object.visible = false
		target_object.set("collision_layer", 0)

func begin_minigame(argument_values):
	var minigame_id : String = argument_values[0]
	match minigame_id:
		"bike_repair":
			active_minigame = Flow.bike_repair_UI
		"seat_sorting":
			active_minigame = Flow.seat_sorting_UI
	if active_minigame != null:
		active_minigame.show()

func end_minigame(_argument_values):
	active_minigame.hide()
	active_minigame = null

func update_dialogue_UI(argument_values):
	var character_id : String = argument_values[0]
	Flow.dialogue_UI.update_UI(character_id)

func play_cutscene(argument_values):
	var cutscene_id : String = argument_values[0]
	match cutscene_id:
		"chew_on_player":
			var canster : class_canster = Flow.dialogue_UI.interact_node
			Flow.player.chew_on_player(canster)
		"drop_player":
			var taxi : class_character = Flow.dialogue_UI.interact_node
			Flow.player.drop_player(taxi)
		"respawn":
			respawn()

func respawn_player(_argument_values):
	Flow.player.respawn()

func teleport_player(argument_values):
	var character_id : String = argument_values[0]
	var player : class_player = Flow.player

	var character = State.get_character_by_id(character_id)
	if character:
		var object : class_character = character.object
		var target_position : Vector2 = object.position
		target_position += Vector2(0, -50)
		player.teleport(target_position)

func fade_to_opaque(argument_values : Array):
	var duration : float = argument_values[0]
	Flow.transitions_UI.fade_to_opaque(duration)

func fade_to_transparent(argument_values : Array):
	var duration : float = argument_values[0]
	Flow.transitions_UI.fade_to_transparent(duration)

var external_setters : Dictionary = {
	"PAN_CAMERA" : {
		"callback": funcref(self, "pan_camera"),
		"argument_types": [TYPE_STRING]
	},
	"ADD_ITEM" : {
		"callback": funcref(self, "add_item"),
		"argument_types": [TYPE_STRING]
	},
	"REMOVE_ITEM" : {
		"callback": funcref(self, "remove_item"),
		"argument_types": [TYPE_STRING]
	},
	"SHOW" : {
		"callback": funcref(self, "show"),
		"argument_types": [TYPE_STRING]
	},
	"HIDE" : {
		"callback": funcref(self, "hide"),
		"argument_types": [TYPE_STRING]
	},
	"BEGIN_MINIGAME" : {
		"callback": funcref(self, "begin_minigame"),
		"argument_types": [TYPE_STRING]
	},
	"END_MINIGAME" : {
		"callback": funcref(self, "end_minigame"),
		"argument_types": []
	},
	"SET_STATE_PROPERTY" : {
		"callback": funcref(self, "set_state_property"),
		"argument_types": [TYPE_STRING, TYPE_STRING, TYPE_INT]
	},
	"UPDATE_UI" : {
		"callback": funcref(self, "update_dialogue_UI"),
		"argument_types": [TYPE_STRING]
	},
	"PLAY_CUTSCENE" : {
		"callback": funcref(self, "play_cutscene"),
		"argument_types": [TYPE_STRING]
	},
	"RESPAWN_PLAYER" : {
		"callback": funcref(self, "respawn_player"),
		"argument_types": []
	},
	"TELEPORT_PLAYER" : {
		"callback": funcref(self, "teleport_player"),
		"argument_types": [TYPE_STRING]
	}
}

### CUTSCENES ###
func respawn():
	var player : class_player = Flow.player
	var anim_sprite := player.get_node("AnimatedSprite")

	# Position is taken here to acount for previous cutscenes!!!
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position, anim_sprite.position + Vector2(0, -200), 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.interpolate_property(anim_sprite, "rotation_degrees", anim_sprite.rotation_degrees, 0, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(player,"position", player.position, player.respawn_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position + Vector2(0, -200), Vector2(0, -200), 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", Vector2(0, -200), Vector2.ZERO, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	
	emit_signal("cutscene_ended")
