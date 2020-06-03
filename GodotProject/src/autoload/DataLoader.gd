# Loader for all the game's data.
extends Node

func load_dataJSON() -> int:
	## Load all the controls from the default JSON.
	var error : int = OK
	var data_dictionary = Flow.load_JSON(Flow.DATA_PATH)

	var constants_data : Dictionary = data_dictionary.get("CONSTANTS", {})
	for key in constants_data.keys():
		if Flow.get(key) != null:
			Flow.set(key, constants_data.get(key, Flow.get(key)))
		else:
			push_error("Failed to set configuration property {0}!".format([key]))

	Flow.character_data = data_dictionary.get("characters", {})
	Flow.item_data = data_dictionary.get("items", {})
	return error
