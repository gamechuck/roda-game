extends MarginContainer

onready var _inventory_button := $HBoxContainer/VBoxContainer/InventoryButton
onready var _inventory_vbox := $HBoxContainer/VBoxContainer/InventoryVBox

var _is_open := false setget set_is_open

func _ready():
	Flow.inventory_overlay = self
	
	var _error := _inventory_button.connect("pressed", self, "toggle_inventory")
	set_is_open(_is_open)

func set_is_open(value : bool):
	_is_open = value
	_inventory_vbox.visible = _is_open

func toggle_inventory():
	set_is_open(not _is_open)

func add_item(item : class_item):
	var item_id := item.name
	var item_data := Flow.get_item_data(item_id)
	for slot in _inventory_vbox.get_children():
		if not slot is class_item_slot:
			continue
		if slot.is_empty:
			slot.add_item(item_id, item_data)
			item.queue_free()
			item = null
			return
	push_error("No empty inventory slots could be found!")

func has_item(item_id : String) -> bool:
	for slot in _inventory_vbox.get_children():
		if not slot is class_item_slot:
			continue
		if slot.item_id == item_id:
			return true
	return false
