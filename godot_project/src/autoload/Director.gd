extends Node

onready var _tween := $Tween

var story : Object
var interact_node : Node2D = null

var minigame : classMinigame = null

var is_waiting_for_choice := false
var dialogue_in_progress := false
var cutscene_in_progress := false

var dialogue_can_be_updated := true

signal revoke_player_autonomy
signal grant_player_autonomy

signal dialogue_completed
signal cutscene_completed

signal change_level_requested

func reset() -> void:
	is_waiting_for_choice = false
	dialogue_in_progress = false
	cutscene_in_progress = false

	dialogue_can_be_updated = true

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

func start_knot_dialogue(node: Node2D, knot : String) -> void:
	# First stop the player autonomy!
	emit_signal("revoke_player_autonomy")

	story.variables_state.set("interact_id", node.state.id)
	story.variables_state.set("conv_type", 0)
	interact_node = node

	if story.knot_container_with_name(knot) != null:
		story.choose_path_string(knot)
		dialogue_in_progress = update_dialogue()
	else:
		push_error("Could not find knot '{0}' in compiled INK-file.".format([knot]))
		_stop_dialogue()

func _on_cutscene_requested(cutscene_id : String, argument_values : Array = []) -> void:
	if not cutscene_in_progress:
		# First stop the player autonomy!
		emit_signal("revoke_player_autonomy")
		cutscene_in_progress = true

		match cutscene_id:
			"respawn":
				respawn()
				yield(self, "cutscene_completed")
			"teleport_to_waypoint":
				var waypoint_id : String = argument_values[0]
				for waypoint in get_tree().get_nodes_in_group("waypoints"):
					if waypoint.id == waypoint_id:
						var position : Vector2 = waypoint.position
						teleport_to_position(position)
						yield(self, "cutscene_completed")
						break
			"drop_player":
				if interact_node is classCharacter:
					drop_player(interact_node)
					yield(self, "cutscene_completed")
			"eat_player":
				if interact_node is classCharacter:
					eat_player(interact_node)
					yield(self, "cutscene_completed")
			"spit_out_player":
				if interact_node is classCharacter:
					spit_out_player(interact_node)
					yield(self, "cutscene_completed")
			"fade_to_black_and_back":
				fade_to_black_and_back()
				yield(self, "cutscene_completed")
			"intro":
				play_intro()
				yield(self, "cutscene_completed")
			"outro":
				play_outro()
				yield(self, "cutscene_completed")
			"escort_blind_guy":
				escort_blind_guy()
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
	if interact_node is classCharacter:
		interact_node.play_sound_byte()
		state = interact_node.state

	elif interact_node is classPickup:
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
			text = text.strip_edges()
			Flow.dialogue_UI.update_dialogue(text)
			Flow.dialogue_UI.show()
			return true
		else:
			return update_dialogue()
	elif story.current_choices.size() > 0:
		is_waiting_for_choice = true

		if Director.minigame == null:
			var choices := []
			for choice in story.current_choices:
				choices.append(choice.text)
			Flow.dialogue_UI.update_multiple_choice(choices)

		#story.choose_choice_index(0)
		return true
	else:
		_stop_dialogue()
		return false

func _stop_dialogue() -> void:
	Flow.dialogue_UI.hide()
	emit_signal("dialogue_completed")
	if not cutscene_in_progress:
		emit_signal("grant_player_autonomy")

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

	return external_dict.get("can_continue", true)

func pan_camera_to_position(argument_values : Array):
	var x_pos : int = argument_values[0]
	var y_pos : int = argument_values[1]
	var game_camera : Camera2D = Flow.game_camera

	var offset : Vector2 = Vector2(x_pos, y_pos)
	offset -= Flow.player.position

	_tween.interpolate_property(game_camera, "offset", game_camera.offset, offset, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.start()

func reset_camera(_argument_values : Array):
	var game_camera : Camera2D = Flow.game_camera
	_tween.interpolate_property(game_camera, "offset", game_camera.offset, Vector2.ZERO, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.start()

func zoom_camera(target_zoom : Vector2):
	var game_camera : Camera2D = Flow.game_camera
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
		target_object.set_visible(true)

func hide(argument_values):
	var mask : String = argument_values[0]
	var skater_loops : Node2D = get_tree().root.get_node("Game/ViewportContainer/MainLevel/SkaterLoops")
	if skater_loops:
		for child in skater_loops.get_children():
			child.set_visible(false)

func begin_minigame(argument_values):
	var minigame_id : String = argument_values[0]

	for node in get_tree().get_nodes_in_group("minigames"):
		if node.id == minigame_id:
			minigame = node
			minigame.show()

func end_minigame(_argument_values):
	minigame.hide()
	minigame = null

func update_dialogue_UI(argument_values):
# WEIRD function....
	var character_id : String = argument_values[0]

	var character : classCharacterState = State.get_character_by_id(character_id)
	if character:
		var object = character.object
		Director.interact_node = object

func start_cutscene(argument_values : Array) -> void:
	var cutscene_id : String = argument_values[0]
	_on_cutscene_requested(cutscene_id)

func respawn_player(_argument_values : Array) -> void:
	_on_cutscene_requested("respawn")

func teleport_to_waypoint(argument_values : Array):
	_on_cutscene_requested("teleport_to_waypoint", argument_values)

var external_setters : Dictionary = {
	"TELEPORT_TO_WAYPOINT" : {
		"callback": funcref(self, "teleport_to_waypoint"),
		"argument_types": [TYPE_STRING],
		"can_continue": false
	},
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
	"UPDATE_UI" : {
		"callback": funcref(self, "update_dialogue_UI"),
		"argument_types": [TYPE_STRING]
	},
	"PLAY_CUTSCENE" : {
		"callback": funcref(self, "start_cutscene"),
		"argument_types": [TYPE_STRING],
		"can_continue": false
	},
	"RESPAWN_PLAYER" : {
		"callback": funcref(self, "respawn_player"),
		"argument_types": [],
		"can_continue": false
	},
	"FADE_TO_OPAQUE": {
		"callback": funcref(self, "fade_to_opaque"),
		"argument_types": [],
		"can_continue": false
	},
	"FADE_TO_TRANSPARENT": {
		"callback": funcref(self, "fade_to_transparent"),
		"argument_types": [],
		"can_continue": false
	}
}

### CUTSCENES ###
func respawn() -> void:
	var player : Node2D = Flow.player
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

func teleport_to_position(to : Vector2) -> void:
	var player : Node2D = Flow.player

	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	_tween.interpolate_property(player, "position", player.position, to, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_in_progress = update_dialogue()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func fade_to_black_and_back() -> void:
	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_in_progress = update_dialogue()
	Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func fade_to_opaque(_argument_values : Array):
	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_in_progress = update_dialogue()
	if story.can_continue:
		Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func fade_to_transparent(_argument_values : Array):
	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_in_progress = update_dialogue()
	if story.can_continue:
		Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func drop_player(taxi : classCharacter):
	var player : Node2D = Flow.player
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

func escort_blind_guy():
	var level : classLevel = Flow.level

	# Block the dialogue from updating
	dialogue_can_be_updated = false
	Flow.dialogue_UI.hide()

	# Gather up all the cutscene's actors!
	var player := level.get_node("Sorted/Player")

	var blind_guy := level.get_node("Sorted/Characters/BlindGuy")

	var waypoint := level.get_node("Waypoints/BlindGuyStart")
	var position_start = waypoint.position

	waypoint = level.get_node("Waypoints/BlindGuyStop")
	var position_stop = waypoint.position

	var game_camera : Camera2D = Flow.game_camera

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	# Make sure the player isn't riding his bike!
	story.variables_state.set("player_on_bike", 0)

	game_camera.track_player = false
	game_camera.zoom = Vector2(1.5, 1.5)
	game_camera.position = Vector2(2336, 1888)

	player.position = position_start
	player.position.x -= 32

	var duration : float = position_start.distance_to(position_stop)
	duration /= ConfigData.PLAYER_MOVE_SPEED

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	blind_guy.update_state(Vector2.DOWN)
	player.update_state(Vector2.DOWN)

	_tween.interpolate_property(player, "position:y", position_start.y, position_stop.y, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(blind_guy, "position:y", position_start.y, position_stop.y, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	blind_guy.update_state()
	player.update_state()

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	game_camera.track_player = true
	game_camera.zoom = Vector2(1, 1)

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	dialogue_in_progress = update_dialogue()
	Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func eat_player(canster : classCanster):
	var player : Node2D = Flow.player
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

	canster_anim_sprite.play("default")

	dialogue_in_progress = update_dialogue()
	Flow.dialogue_UI.show()
	dialogue_can_be_updated = true

	emit_signal("cutscene_completed")

func spit_out_player(canster : classCanster):
	var player : classPlayer = Flow.player
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

	canster_anim_sprite.play("default")

	_tween.interpolate_property(player,"position", player.position, player.respawn_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position + Vector2(0, -200), Vector2(0, -200), 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", Vector2(0, -200), Vector2.ZERO, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	dialogue_in_progress = update_dialogue()

	emit_signal("cutscene_completed")

func play_intro():
	var level : classLevel = Flow.level

	# Gather up all the cutscene's actors!
	var player := level.get_node("Sorted/Player")

	var solid_snejk := level.get_node("Sorted/Characters/SolidSnejk")
	var happy_tree := level.get_node("Sorted/Characters/HappyTree")
	var returned_bike := level.get_node("Sorted/Characters/ReturnedBike")
	var mr_smog := level.get_node("Sorted/Characters/MrSmog")

	var ball := level.get_node("Sorted/Props/Ball")

	var fence_top := level.get_node("Sorted/Fences/Top")
	var fence_bottom := level.get_node("Sorted/Fences/Bottom")
	var fence_left := level.get_node("Sorted/Fences/Left")
	var fence_right := level.get_node("Sorted/Fences/Right")

	player._direction = player.DIRECTION.UP
	player.update_animation()

	var smog_material := preload("res://assets/materials/smog_fog_material.tres")
	var game_camera : Camera2D = Flow.game_camera

	game_camera.track_player = false
	game_camera.zoom = Vector2(1.5, 1.5)
	game_camera.position = Vector2(2336, 2208)

	start_knot_dialogue(player, "conv_intro")
	yield(self, "dialogue_completed")

	_tween.interpolate_property(solid_snejk,"position:y", solid_snejk.position.y, solid_snejk.position.y - 20, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(solid_snejk,"position:y", solid_snejk.position.y - 20, solid_snejk.position.y, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN, 1.0)
	_tween.interpolate_property(ball,"position:y", ball.position.y, ball.position.y + 120, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1.5)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(player,"position:y", player.position.y, player.position.y + 20, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(player,"position:y", player.position.y + 20, player.position.y, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN, 1.0)
	_tween.interpolate_property(ball,"position:y", ball.position.y, ball.position.y - 120, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1.5)
	_tween.start()
	yield(_tween, "tween_all_completed")

	start_knot_dialogue(player, "conv_intro_slug_no_ball")
	yield(self, "dialogue_completed")

	_tween.interpolate_property(solid_snejk,"position:y", solid_snejk.position.y, solid_snejk.position.y - 20, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(solid_snejk,"position:y", solid_snejk.position.y - 20, solid_snejk.position.y, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN, 1.0)
	_tween.interpolate_property(ball,"position:y", ball.position.y, ball.position.y + 120, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1.5)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(smog_material, "shader_param/amount", 0, 0.5, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.interpolate_property(player,"position:y", player.position.y, player.position.y + 20, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(player,"position:y", player.position.y + 20, player.position.y, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN, 1.0)
	_tween.interpolate_property(ball,"position:y", ball.position.y, ball.position.y - 120, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, 1.5)
	_tween.start()
	yield(_tween, "tween_all_completed")

	AudioEngine.play_music("game_smog")

	start_knot_dialogue(player, "conv_intro_smog_appears")
	yield(self, "dialogue_completed")

	_tween.interpolate_property(mr_smog,"position:y", mr_smog.position.y, happy_tree.position.y - 72, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	start_knot_dialogue(player, "conv_intro_mr_smog_taunts")
	yield(self, "dialogue_completed")

	# SMOG SMASH
	_tween.interpolate_property(happy_tree,"position:y", happy_tree.position.y, happy_tree.position.y - 20, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(mr_smog,"position:y", mr_smog.position.y, mr_smog.position.y - 20, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(happy_tree,"position:y", happy_tree.position.y -20, happy_tree.position.y, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT, 0.5)
	_tween.interpolate_property(mr_smog,"position:y", mr_smog.position.y -20, mr_smog.position.y, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT, 0.5)
	_tween.start()
	yield(_tween, "tween_all_completed")

	# Everything flies away!
	_tween.interpolate_property(fence_bottom,"position:y", fence_bottom.position.y, fence_bottom.position.y +200, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(fence_top,"position:y", fence_top.position.y, fence_top.position.y - 200, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(fence_left,"position:x", fence_left.position.x, fence_left.position.x - 400, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(fence_right,"position:x", fence_right.position.x, fence_right.position.x + 400, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(ball,"position:x", ball.position.x, ball.position.x + 400, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(returned_bike,"position:y", returned_bike.position.y, returned_bike.position.y + 400, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	start_knot_dialogue(player, "conv_intro_mr_smog_exits")
	yield(self, "dialogue_completed")

	_tween.interpolate_property(happy_tree,"position:x", happy_tree.position.x, happy_tree.position.x - 600, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(mr_smog,"position:x", mr_smog.position.x, mr_smog.position.x - 600, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	start_knot_dialogue(player, "conv_intro_outro")
	yield(self, "dialogue_completed")

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	emit_signal("change_level_requested", "main")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	start_knot_dialogue(Flow.player, "conv_solid_snejk")
	yield(self, "dialogue_completed")

	emit_signal("cutscene_completed")

func play_outro():
	var level : classLevel = Flow.level

	# Gather up all the cutscene's actors!
	var player := level.get_node("Sorted/Player")
	var mayor := level.get_node("Sorted/Characters/Mayor")
	var game_camera : Camera2D = Flow.game_camera

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	player.position = Flow.get_waypoint_position("protesting_player")
	player.update_state(Vector2.DOWN)

	game_camera.track_player = false
	game_camera.zoom = Vector2(2, 2)
	game_camera.position = Vector2(2336, 2308)

	mayor.set_visible(true)

	start_knot_dialogue(player, "conv_outro_intro")
	yield(self, "dialogue_completed")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	start_knot_dialogue(player, "conv_outro")
	yield(self, "dialogue_completed")

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	emit_signal("change_level_requested", "outro")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	start_knot_dialogue(Flow.player, "conv_solid_snejk")
	yield(self, "dialogue_completed")

	emit_signal("cutscene_completed")
