# State is an autoload script that contains all global state variables.
extends Node

var _item_resource := preload("res://src/autoload/state/ItemState.gd")
var _character_resource := preload("res://src/autoload/state/CharacterState.gd")
var _pickup_resource := preload("res://src/autoload/state/PickupState.gd")

func _ready():
	## If it doesn't exist, create the saves-folder in user://
	var dir : Directory = Directory.new()
	if not dir.dir_exists(Flow.SAVE_FOLDER):
		print("Creating saves-folder at '{0}' (First-time initialization).".format([Flow.SAVE_FOLDER]))
		var error : int = dir.make_dir(Flow.SAVE_FOLDER)
		if error != OK:
			push_error("Failed to create saves-folder due to error '{0}'.".format([error]))

func load_stateJSON(path : String = Flow.DEFAULT_CONTEXT_PATH) -> int:
	## Load a previous State from a file defined in the user://saves-folder or the default one.
	var context : Dictionary = Flow.load_JSON(path)
	if not context.empty():
		load_state_from_context(context)
		return OK
	else:
		return ERR_FILE_CORRUPT

func save_stateJSON(path : String = Flow.USER_SAVE_PATH) -> int:
	## Save the current State to the user://saves-folder.
	var context : Dictionary = save_state_to_context()
	return Flow.save_JSON(path, context)

## STATE ######################################################################

func load_state_from_context(context : Dictionary) -> void:
	print_debug("Loading state from the context...")

	items.clear()
	characters.clear()
	pickups.clear()

	for item_context in context.get("items", []):
		add_item_from_context(item_context)

	init_characters()
	for character_context in context.get("characters", []):
		set_character_from_context(character_context)

	init_pickups()
	for pickup_context in context.get("pickups", []):
		set_pickup_from_context(pickup_context)

func save_state_to_context() -> Dictionary:
	var context := {}

	var context_dict := {
		"items": items,
		"characters": characters,
		"pickups": pickups
	}

	for key in context_dict.keys():
		context[key] = []
		for context_owner in context_dict[key]:
			var subcontext : Dictionary = context_owner.context
			if not subcontext.empty():
				context[key].append(subcontext)

	return context

## ITEMS #######################################################################
var items := []

func add_item_from_context(item_context : Dictionary) -> void:
	var item_id : String = item_context.get("id", "MISSING ID")
	var item_to_be_added := get_item_by_id(item_id)
	if item_to_be_added:
		item_to_be_added.amount += 1
	else:
		var item := _item_resource.new()
		item.context = item_context

		items.append(item)

func add_item_by_id(item_id : String) -> void:
	var item_to_be_added := get_item_by_id(item_id)
	if item_to_be_added:
		item_to_be_added.amount += 1
	else:
		var item = _item_resource.new()
		item.id = item_id
		item.amount = 1

		if ConfigData.verbose_mode: print("adding brand-new item with id '{0}' to State!".format([item_id]))
		items.append(item)

func remove_item_by_id(item_id : String) -> void:
	var item_to_be_removed := get_item_by_id(item_id)
	if item_to_be_removed:
		item_to_be_removed.amount -= 1
		if item_to_be_removed.amount == 0:
			items.erase(item_to_be_removed)
	else:
		push_error("Item with id '{0}' was not found in inventory!".format([item_id]))

func get_item_by_id(item_id : String) -> class_item_state:
	for item in items:
		if item.id == item_id:
			return item
	# It's okay if the item wasn't added to the state previously!
	return null

func has_item(item_id : String) -> bool:
	if get_item_by_id(item_id):
		return true
	else:
		return false

## CHARACTERS ##################################################################
var characters := []

func init_characters() -> void:
	for key in Flow.characters_data.keys():
		var character := _character_resource.new()
		character.id = key

		if ConfigData.verbose_mode: print("Adding registered character with id '{0}' to State!".format([key]))
		characters.append(character)

func set_character_from_context(character_context : Dictionary) -> void:
	if character_context.has("id"):
		var character_id = character_context.id
		for character in characters:
			if character.id == character_id:
				character.context = character_context
				break

func get_character_by_id(character_id : String) -> class_character_state:
	for character in characters:
		if character.id == character_id:
			return character
	push_error("Character with id '{0}' is not available in the State!".format([character_id]))
	return null

## PICKUPS #####################################################################
var pickups := []

func init_pickups() -> void:
	for key in Flow.pickups_data.keys():
		var pickup := _pickup_resource.new()
		pickup.id = key

		if ConfigData.verbose_mode: print("Adding registered pickup with id '{0}' to State!".format([key]))
		pickups.append(pickup)

func set_pickup_from_context(pickup_context : Dictionary) -> void:
	if pickup_context.has("id"):
		var pickup_id = pickup_context.id
		for pickup in pickups:
			if pickup.id == pickup_id:
				pickup.context = pickup_context
				break

func get_pickup_by_id(pickup_id : String) -> class_pickup_state:
	for pickup in pickups:
		if pickup.id == pickup_id:
			return pickup
	push_error("Pickup with id '{0}' is not available in the State!".format([pickup_id]))
	return null
