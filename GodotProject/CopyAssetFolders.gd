extends SceneTree

# Example usage:
# 'godot -s CopyDataFolder.gd "--build-path build/windows-dev"'
# Will copy all the asset folders to ../build/windows-dev

# Extend to other folders if necessary!
const DATA_FOLDERS : Array = ["data", "inklecate"]

# Globalized build path is necessary because make_dir() doesn't take relative paths.
var _globalized_build_path : String = ""

func _init():

	# Process commmand line arguments, "--build-path" should be supplied!
	var args : Array = OS.get_cmdline_args()
	var dir : Directory = Directory.new()
	var build_path : String = ""
	for argument in args:
		if "--build-path " in argument:
			build_path = argument
			build_path = build_path.replace("--build-path ", "")
			break

	# Check if build path was given at all...
	if build_path.empty():
		print("ERROR: Build path was undeclared!")
		quit()
		return

	# Get a globalized version of the build path... otherwise
	# make_dir() refuses to create the necessary directories! 
	_globalized_build_path = ProjectSettings.globalize_path("res://")
	var split_array : PoolStringArray = _globalized_build_path.split("/", false)
	# Remove the Godot project folder's name.
	split_array.remove(split_array.size()-1)
	_globalized_build_path = split_array.join("/") + "/" + build_path

	# Check if the globalized build path actually exists!
	if not dir.dir_exists(_globalized_build_path):
		# Do a last attempt to make the global build path work!
		# This is necessary for Gitlab CI, when there's no drive point!
		if not dir.dir_exists("/" + _globalized_build_path):
			print("ERROR: Globalized build path '{0}' did not exist!".format([_globalized_build_path]))
			quit()
			return
		else:
			_globalized_build_path = "/" + _globalized_build_path

	print("- NOW COPYING DATA FOR '{0}' -".format([build_path]))
	# Recursively copy all of the contents of the data folders to the build folder.
	for current_folder in DATA_FOLDERS:
		_copy_directory_content(current_folder)

	# Copy the options.cfg to the build folder.
	# This .cfg is only used for editor purposes and the development builds.
	print("Copying 'options.cfg'")
	dir.copy("options.cfg", "{0}/options.cfg".format([_globalized_build_path]))

	# Copy the default_controls.json to the build folder.
	print("Copying 'controls.json'")
	dir.copy("controls.json", "{0}/controls.json".format([_globalized_build_path]))

	quit()

func _copy_directory_content(current_folder : String):
	var dir : Directory = Directory.new()
	var target_folder : String = _globalized_build_path + "/" + current_folder
	var source_folder : String = "res://" + current_folder
	var err = dir.make_dir(target_folder)
	if not err == OK and not err == ERR_ALREADY_EXISTS:
		print("ERROR: Directory with path '{0}' could not be created! (with ERROR {1})".format([target_folder, err]))
		quit()
		return

	if dir.open(current_folder) == OK:
		dir.list_dir_begin();
		var file_name : String = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				if not [".", ".."].has(file_name):
					print("Descending into child folder '{0}'".format([file_name]))
					_copy_directory_content("{0}/{1}".format([current_folder, file_name]))
			else:
				print("Copying '%s/%s'"%[source_folder, file_name])
				dir.copy(source_folder + "/" + file_name, target_folder + "/" + file_name)
			file_name = dir.get_next()
		dir.list_dir_end();
	else:
		print("Could not open data folder (%s)."%[source_folder])
