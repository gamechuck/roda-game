# Loader for all the game's data.
extends Node

func load_dataJSON() -> int:
	## Load all characters, objects, regions, etc... from the data JSON.
	var data_dict := {
		"data": {
			"path": Flow.DATA_PATH,
			"setter": funcref(self, "_set_data")
		}
	}
	
	var file : File = File.new()
	var error : int = OK

	for key in data_dict.keys():
		var path : String = data_dict[key].path
		if file.file_exists(path):
			if ConfigData.verbose_mode: print("Attempting to load reporting data from '{0}'.".format([path]))
			var data : Dictionary = Flow.load_JSON(path)
			if data.empty():
				push_error("Failed to open the data settings at '{0}' for loading purposes.".format([path]))
			else:
				(data_dict[key].setter as FuncRef).call_func(data) 

		else:
			push_error("Essential file '{0}' does not exist, check its existence!".format([path]))
			error = ERR_FILE_CORRUPT

	return error

func _set_data(data : Dictionary) -> void:
	Flow.characters_data = data.get("characters", {})
	Flow.items_data = data.get("items", {})
	Flow.pickups_data = data.get("pickups", {})
