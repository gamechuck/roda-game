extends TextureRect
class_name class_item_slot

var inventory_item : class_inventory_item setget set_inventory_item, get_inventory_item
var _inventory_item := WeakRef.new()
func set_inventory_item(value : class_inventory_item) -> void:
	_inventory_item = weakref(value)
func get_inventory_item() -> class_inventory_item:
	return _inventory_item.get_ref()

var pressed := false setget set_pressed, get_pressed
func set_pressed(value : bool):
	pressed = value
	_texture_button.pressed = value
func get_pressed() -> bool:
	return pressed

var amount : int setget , get_amount
func get_amount():
	var item : class_inventory_item = self.inventory_item
	if item:
		return item.amount
	else:
		return 0

onready var _texture_button := $TextureButton
onready var _amount_label := $Node2D/AmountLabel

func _ready():
	var _error : int = _texture_button.connect("pressed", self, "_on_button_pressed")
	clear_item()

func _on_button_pressed():
	var item := self.inventory_item
	if item != null:
		# Dont change pressed here! This will be done by the overlay instead!
		#pressed = _texture_button.pressed
		# This triggers the setter function of the InventoryItem.gd which will
		# take care of everything!
		item.pressed = _texture_button.pressed

func set_item(item : class_inventory_item):
	var data : Dictionary = Flow.get_item_data(item.id)

	var textures : Dictionary = data.get("TEXTURES", {})
	var texture_normal_path : String = textures.get("TEXTURE_NORMAL", Flow.FALLBACK_INVENTORY_TEXTURE)
	var	texture_pressed_path : String = textures.get("TEXTURE_PRESSED", Flow.FALLBACK_INVENTORY_TEXTURE)

	if not ResourceLoader.exists(texture_normal_path):
		texture_normal_path = Flow.FALLBACK_INVENTORY_TEXTURE
	if not ResourceLoader.exists(texture_pressed_path):
		texture_pressed_path = Flow.FALLBACK_INVENTORY_TEXTURE

	self.pressed = item.pressed
	_texture_button.texture_normal = load(texture_normal_path)
	_texture_button.texture_pressed = load(texture_pressed_path)

	self.inventory_item = item
	_update_amount_label()

func clear_item():
	self.pressed = false
	_texture_button.texture_normal = null
	_texture_button.texture_pressed = null

	self.inventory_item = null
	_update_amount_label()

func _update_amount_label():
	var item_amount = get_amount()
	_amount_label.text = "{0} x".format([item_amount])
	if item_amount > 1:
		_amount_label.visible = true
	else:
		_amount_label.visible = false
