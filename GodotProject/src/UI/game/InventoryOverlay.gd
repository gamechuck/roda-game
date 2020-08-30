extends MarginContainer

onready var _inventory_button := $HBoxContainer/VBoxContainer/InventoryButton
onready var _inventory_background := _inventory_button.get_node("Background")

onready var _inventory_vbox := $HBoxContainer/VBoxContainer/InventoryVBox
onready var _slots_container := _inventory_vbox.get_node("Slots")

onready var _up_button := _inventory_vbox.get_node("UpButton")
onready var _down_button := _inventory_vbox.get_node("DownButton")

var pressed : bool setget set_pressed, get_pressed
func set_pressed(value: bool) -> void:
	_inventory_button.pressed = value
	_inventory_vbox.visible = value
	_inventory_background.visible = value
	update_slots()
func get_pressed() -> bool:
	return _inventory_button.pressed

func _ready():
	Flow.inventory = self

	var _error := _inventory_button.connect("pressed", self, "_on_inventory_button_pressed")
	_error = _up_button.connect("pressed", self, "_on_direction_button_pressed", [+1])
	_error = _down_button.connect("pressed", self, "_on_direction_button_pressed", [-1])

	for slot in _slots_container.get_children():
		_error = slot.connect("item_pressed", self, "_on_item_pressed")

	self.pressed = false

func _on_inventory_button_pressed():
	self.pressed = _inventory_button.pressed

func _on_direction_button_pressed(direction : int):
	# Don't allow scrolling when the number of items is below 3
	if State.items.size() < 3:
		return

	if direction == +1:
		var item : class_item_state = State.items.pop_front()
		State.items.push_back(item)
	else:
		var item : class_item_state = State.items.pop_back()
		State.items.push_front(item)
	update_slots()

func _on_item_pressed(_pressed : bool, _item : class_item_state) -> void:
	# Go through all the slots and check their items...
	for slot in _slots_container.get_children():
		if slot.item != _item:
			slot.pressed = false
		else:
			slot.pressed = _pressed

	# Go through all the items as well!
	# Change the active item in the Flow!
	for item in State.items:
		if item != _item:
			item.pressed = false
		else:
			item.pressed = _pressed
			if _pressed:
				Flow.active_item = _item
			else:
				Flow.active_item = null

func reset_slots():
	for slot in _slots_container.get_children():
		slot.pressed = false

	# Go through all the items as well!
	# Change the active item in the Flow!
	for item in State.items:
		item.pressed = false

	Flow.active_item = null

func update_slots():
	var idx := 0
	for slot in _slots_container.get_children():
		if State.items.size() > idx:
			var item : class_item_state = State.items[idx]
			if item:
				slot.item = item
			else:
				slot.item = null
		else:
			slot.item = null
		idx += 1

	if State.items.size() < 3:
		_up_button.disabled = true
		_down_button.disabled = true
	else:
		_up_button.disabled = false
		_down_button.disabled = false

func add_item(pickup : class_pickup) -> void:
	var state = pickup.state
	var item_id = state.item_id
	print(item_id)
	add_item_by_id(item_id)

	pickup.set_visible(false)

func add_item_by_id(item_id : String) -> void:
	State.add_item_by_id(item_id)
	update_slots()

func remove_item_by_id(item_id : String) -> void:
	State.remove_item_by_id(item_id)
	update_slots()
