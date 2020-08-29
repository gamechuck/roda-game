extends Node

onready var _tween := $Tween

var story : Object
var interact_node : Node2D = null
var active_minigame : Control = null

var is_waiting_for_choice := false
var dialogue_in_progress := false
var cutscene_in_progress := false

var dialogue_can_be_updated := true

signal revoke_player_autonomy()
signal grant_player_autonomy()

signal cutscene_completed()

func _on_dialogue_requested(node : Node2D, item_id : String = ""):
	# First stop the player autonomy!
	emit_signal("revoke_player_autonomy")

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

func _on_cutscene_requested(cutscene_id : String, argument_values : Array = []) -> void:
	if not cutscene_in_progress:
		# First stop the player autonomy!
		emit_signal("revoke_player_autonomy")
		cutscene_in_progress = true

		match cutscene_id:
			"respawn":
				respawn()
				yield(self, "cutscene_completed")
			"teleport":
				var character_id : String = argument_values[0]

				var character = State.get_character_by_id(character_id)
				if character:
					var object : class_character = character.object
					var target_position : Vector2 = object.position
					target_position += Vector2(0, -50)

					teleport(target_position)
					yield(self, "cutscene_completed")
			"drop_player":
				if interact_node is class_character:
					drop_player(interact_node)
					yield(self, "cutscene_completed")
			"eat_player":
				if interact_node is class_character:
					eat_player(interact_node)
					yield(self, "cutscene_completed")
			"spit_out_player":
				if interact_node is class_character:
					spit_out_player(interact_node)
					yield(self, "cutscene_completed")
			_:
				push_error("Cutscene with id '{0}' was not recognized!".format([cutscene_id]))
				pass

		cutscene_in_progress = false
		if not dialogue_in_progress:
			emit_signal("grant_player_autonomy")

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
	if dialogue_can_be_updated:
		dialogue_in_progress = update_dialogue()

func _on_choice_button_pressed(choice_index : int = -1) -> void:
	if dialogue_can_be_updated:
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
	if not cutscene_in_progress:
		emit_signal("grant_player_autonomy")

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

func pan_camera_to_position(argument_values : Array):
	var x_pos : int = argument_values[0]
	var y_pos : int = argument_values[1]
	var game_camera : Camera2D = Flow.player.get_node("GameCamera")
	
	var target_position : Vector2 = Vector2(x_pos, y_pos)
	target_position -= Flow.player.position

	_tween.interpolate_property(game_camera, "position", game_camera.position, target_position, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.start()

func reset_camera(_argument_values : Array):
	var game_camera : Camera2D = Flow.player.get_node("GameCamera")

	_tween.interpolate_property(game_camera, "position", game_camera.position, Vector2.ZERO, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
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

func hide(argument_values):
	var mask : String = argument_values[0]
	var target_object = get_tree().root.find_node(mask, true, false)
	if target_object != null:
		target_object.visible = false

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

	var character : class_character_state = State.get_character_by_id(character_id)
	if character:
		var object = character.object
		Director.interact_node = object

func _start_cutscene(argument_values : Array) -> void:
	var cutscene_id : String = argument_values[0]
	_on_cutscene_requested(cutscene_id)

func respawn_player(_argument_values : Array) -> void:
	_on_cutscene_requested("respawn")

func teleport_player(argument_values : Array) -> void:
	_on_cutscene_requested("teleport", argument_values)

var external_setters : Dictionary = {
	"PAN_CAMERA_TO_POSITION" : {
		"callback": funcref(self, "pan_camera_to_position"),
		"argument_types": [TYPE_INT, TYPE_INT]
	},
	"RESET_CAMERA" : {
		"callback": funcref(self, "reset_camera"),
		"argument_types": []
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
		"callback": funcref(self, "_start_cutscene"),
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
func respawn() -> void:
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
	
	emit_signal("cutscene_completed")

func teleport(target_position : Vector2) -> void:
	var player : class_player = Flow.player

	# Block the dialogue from updating
	dialogue_can_be_updated = false

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	_tween.interpolate_property(player, "position", player.position, target_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func drop_player(taxi : class_character):
	var player : class_player = Flow.player
	var anim_sprite := player.get_node("AnimatedSprite")
	var taxi_anim_sprite := taxi.get_node("AnimatedSprite")
	
	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()

	anim_sprite.visible = false
	_tween.interpolate_property(taxi_anim_sprite, "position", Vector2.ZERO, Vector2(0, -100), 2.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	anim_sprite.visible = true
	_tween.interpolate_property(anim_sprite, "rotation_degrees", 0, 90, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(taxi_anim_sprite, "position", Vector2(0, -100), Vector2(-400, -100), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	taxi_anim_sprite.position = Vector2(600, -100)
	_tween.interpolate_property(taxi_anim_sprite,"position",Vector2(600, -100),Vector2(0, -100), 2.0,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(taxi_anim_sprite,"position",Vector2(0, -100),Vector2.ZERO, 2.0,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	
	_tween.interpolate_property(anim_sprite, "rotation_degrees", 90, 0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	dialogue_in_progress = update_dialogue()
	Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func eat_player(canster : class_canster):
	var player : class_player = Flow.player
	var anim_sprite := player.get_node("AnimatedSprite")
	var canster_anim_sprite := canster.get_node("AnimatedSprite")

	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()
	player.update_state(Vector2.ZERO)

	canster_anim_sprite.play("devour_1")
	yield(canster_anim_sprite, "animation_finished")

	anim_sprite.visible = false

	canster_anim_sprite.play("devour_2")
	yield(canster_anim_sprite, "animation_finished")

	canster_anim_sprite.play("aggressive")

	dialogue_in_progress = update_dialogue()
	Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func spit_out_player(canster : class_canster):
	var player : class_player = Flow.player
	var anim_sprite := player.get_node("AnimatedSprite")
	var canster_anim_sprite := canster.get_node("AnimatedSprite")

	dialogue_in_progress = update_dialogue()

	canster_anim_sprite.play("spit_out_1")
	yield(canster_anim_sprite, "animation_finished")

	anim_sprite.position = canster.position - player.position
	anim_sprite.visible = true

	canster_anim_sprite.play("spit_out_2")
	_tween.interpolate_property(anim_sprite, "position:x", anim_sprite.position.x, -600, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position:y", anim_sprite.position.y, -600, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	canster_anim_sprite.play("aggressive")

	_tween.interpolate_property(player,"position", player.position, player.respawn_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position + Vector2(0, -200), Vector2(0, -200), 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", Vector2(0, -200), Vector2.ZERO, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	dialogue_in_progress = update_dialogue()

	emit_signal("cutscene_completed")
