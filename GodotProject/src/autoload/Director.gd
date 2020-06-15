extends Node

onready var _tween := $Tween

var active_minigame : Control = null 

func _parse_command(raw_text : String) -> Dictionary:
## Parse the command (denoted by >>> in INK) and return as a dictionary.
	var processed_text := raw_text.replace(">>>", "").strip_edges()
	var split_text := processed_text.split(":")

	var command_dict := {}
	command_dict.name = split_text[0].strip_edges()
	command_dict.argument_values = []
	var argument_values := split_text[1].split(" ", false)
	for value in argument_values:
		command_dict.argument_values.append(value.strip_edges())

	return command_dict

func execute_command(raw_text : String):

	var command_dict := _parse_command(raw_text) 
	
	var argument_values : Array = command_dict.argument_values
	var external_dict : Dictionary = external_setters.get(command_dict.name, {})
	var argument_types : Array = external_dict.get("argument_types", [])
	var variable_number_of_arguments : bool = external_dict.get("variable_number_of_arguments", false)
	if not external_dict.empty():
		if argument_types.size() != argument_values.size() and not variable_number_of_arguments:
			push_error("Number of arguments of external setter function '{0}' was incorrect! Requires {1} arguments!".format([command_dict.name, argument_types.size()]))
			return

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

		var callback : FuncRef = external_dict.callback
		callback.call_func(argument_values)

func pan_camera(argument_values : Array):
	var mask : String = argument_values[0]
	var target_object = get_tree().root.find_node(mask, true, false)
	var game_camera : Camera2D = Flow.player.get_node("GameCamera")
	if target_object != null:
		var target_position : Vector2 = target_object.position
		target_position -= Flow.player.position

		_tween.interpolate_property(
			game_camera, 
			"position", 
			game_camera.position, 
			target_position, 
			1, 
			Tween.TRANS_CUBIC, 
			Tween.EASE_IN_OUT)
		_tween.start()

func add_item(argument_values):
	var item_id : String = argument_values[0]
	Flow.inventory_overlay.add_item_by_id(item_id)

func remove_item(argument_values):
	var item_id : String = argument_values[0]
	Flow.inventory_overlay.remove_item_by_id(item_id)

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
			active_minigame.visible = true

func end_minigame(argument_values):
	var minigame_id : String = argument_values[0]
	match minigame_id:
		"bike_repair":
			active_minigame.visible = false
			active_minigame = null

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
		"argument_types": [TYPE_STRING]
	}
}
