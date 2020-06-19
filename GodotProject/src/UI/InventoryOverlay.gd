extends MarginContainer

onready var _inventory_button := $HBoxContainer/VBoxContainer/InventoryButton
onready var _inventory_background := _inventory_button.get_node("Background")

onready var _inventory_vbox := $HBoxContainer/VBoxContainer/InventoryVBox
onready var _slots_container := _inventory_vbox.get_node("Slots")

func _ready():
	Flow.inventory_overlay = self

	var _error := _inventory_button.connect("pressed", self, "update_inventory")
	for slot in _slots_container.get_children():
		_error = slot.connect("pressed", self, "_on_item_slot_pressed", [slot])
	update_inventory()

func update_inventory():
	_inventory_vbox.visible = _inventory_button.pressed
	_inventory_background.visible = _inventory_button.pressed

func _on_item_slot_pressed(pressed : bool, pressed_slot : class_item_slot):
	for slot in _slots_container.get_children():
		if not slot is class_item_slot:
			continue
		if slot != pressed_slot:
			slot.pressed = false
		else:
			if pressed:
				Flow.active_item_slot = pressed_slot
			else:
				Flow.active_item_slot = null

func add_item(item : class_item):
	var item_id := item.name
	var success := add_item_by_id(item_id)
	if success:
		item.queue_free()
		item = null

func add_item_by_id(item_id : String) -> bool:
	var item_data := Flow.get_item_data(item_id)
	for slot in _slots_container.get_children():
		if not slot is class_item_slot:
			continue
		if slot.empty():
			slot.add_item(item_id, item_data)
			return true
		elif slot.item_id == item_id:
			slot.increase_item_count()
			return true
	push_error("No empty inventory slots could be found!")
	return false

func remove_item_by_id(item_id : String):
	for slot in _slots_container.get_children():
		if not slot is class_item_slot:
			continue
		if slot.item_id == item_id:
			slot.decrease_item_count()
			return
	push_error("Item with id '{0}' was not found in inventory!".format([item_id]))

func has_item(item_id : String) -> bool:
	for slot in _slots_container.get_children():
		if not slot is class_item_slot:
			continue
		if slot.item_id == item_id:
			return true
	return false
