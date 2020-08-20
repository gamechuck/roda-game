extends MarginContainer

onready var _inventory_button := $HBoxContainer/VBoxContainer/InventoryButton
onready var _inventory_background := _inventory_button.get_node("Background")

onready var _inventory_vbox := $HBoxContainer/VBoxContainer/InventoryVBox
onready var _slots_container := _inventory_vbox.get_node("Slots")

onready var _up_button := _inventory_vbox.get_node("UpButton")
onready var _down_button := _inventory_vbox.get_node("DownButton")

# Array of references to inventory items.
var _inventory_items := []
var _inventory_item_resource := preload("res://src/UI/game/InventoryItem.gd")

func _ready():
	Flow.inventory_overlay = self

	var _error := _inventory_button.connect("pressed", self, "update_inventory")
	_error = _up_button.connect("pressed", self, "_on_direction_button_pressed", [+1])
	_error = _down_button.connect("pressed", self, "_on_direction_button_pressed", [-1])

	update_inventory()

func toggle_inventory():
	_inventory_button.pressed = not _inventory_button.pressed
	update_inventory()

func update_inventory():
	_inventory_vbox.visible = _inventory_button.pressed
	_inventory_background.visible = _inventory_button.pressed

func _on_direction_button_pressed(direction : int):
	# Don't allow scrolling when the number of items is below 3
	if _inventory_items.size() < 3:
		return

	if direction == +1:
		var first_item : class_inventory_item = _inventory_items.pop_front()
		_inventory_items.push_back(first_item)
	else:
		var last_item : class_inventory_item = _inventory_items.pop_back()
		_inventory_items.push_front(last_item)
	update_slots()

func _on_inventory_item_pressed(pressed : bool, pressed_item : class_inventory_item) -> void:
	for item_slot in _slots_container.get_children():
		if item_slot.inventory_item != pressed_item:
			item_slot.pressed = false
		else:
			item_slot.pressed = pressed

	for item in _inventory_items:
		if item != pressed_item:
			# Bypass the setter here!
			item._pressed = false
		else:
			if pressed:
				Flow.active_inventory_item = item
			else:
				Flow.active_inventory_item = null

func update_slots():
	var idx := 0
	for slot in _slots_container.get_children():
		if _inventory_items.size() > idx:
			var item : class_inventory_item = _inventory_items[idx]
			if item:
				slot.set_item(item)
			else:
				slot.clear_item()
		else:
			slot.clear_item()
		idx += 1
	
	if _inventory_items.size() < 3:
		_up_button.disabled = true
		_down_button.disabled = true
	else:
		_up_button.disabled = false
		_down_button.disabled = false

func add_item(item : class_item) -> void:
	var item_id := item.id
	add_item_by_id(item_id)
	item.queue_free()
	item = null

func add_item_by_id(item_id : String) -> void:
	var item_to_be_added := _get_item_with_id(item_id)
	if item_to_be_added:
		item_to_be_added.amount += 1
	else:
		var item = _inventory_item_resource.new()
		_inventory_items.push_back(item)

		item.connect("pressed", self, "_on_inventory_item_pressed", [item])
		item.id = item_id
		item.amount = 1
	update_slots()

func remove_item_by_id(item_id : String) -> void:
	var item_to_be_removed := _get_item_with_id(item_id)
	if item_to_be_removed:
		item_to_be_removed.amount -= 1
		if item_to_be_removed.amount == 0:
			_inventory_items.erase(item_to_be_removed)
		update_slots()
	else:
		push_error("Item with id '{0}' was not found in inventory!".format([item_id]))

func has_item(item_id : String) -> bool:
	for item in _inventory_items:
		if not item is class_inventory_item:
			continue
		if item.id == item_id:
			return true
	return false

func _get_item_with_id(item_id : String) -> class_inventory_item:
	for item in _inventory_items:
		if not item is class_inventory_item:
			continue
		if item.id == item_id:
			return item
	return null
