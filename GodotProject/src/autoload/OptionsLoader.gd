# Loader/saver for all the configuration variables.
extends Node

func load_optionsCFG() -> int:
## Load the game and editor options to be saved in the GameState.
	var config : ConfigFile = ConfigFile.new()
	var error : int = config.load(Flow.OPTIONS_PATH)
	if error == OK: # if not, something went wrong with the file loading.
		for section_id in config.get_sections():
			for key in config.get_section_keys(section_id):
				if Flow.get(key) != null:
					Flow.set(key, config.get_value(section_id, key, Flow.get(key)))
				else:
					push_error("Failed to set configuration property {0}!".format([key]))

		print("Succesfully loaded and processed '{0}'.".format([Flow.OPTIONS_PATH]))
		return OK
	else:
		push_error("Failed to open '{0}', check file availability!".format([Flow.OPTIONS_PATH]))
		return error
