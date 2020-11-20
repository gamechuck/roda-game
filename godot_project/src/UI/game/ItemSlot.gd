class_name classItemSlot
extends TextureRect

var item : classItemState setget set_item, get_item
func set_item(value : classItemState) -> void:
	_item = weakref(value)
	if value:
		self.pressed = value.pressed

		_texture_button.texture_normal = value.texture_normal
		_texture_button.texture_pressed = value.texture_pressed
	else:
		self.pressed = false

		_texture_button.texture_normal = null
		_texture_button.texture_pressed = null

	_update_amount_label()
func get_item() -> classItemState:
	return _item.get_ref()

var pressed := false setget set_pressed, get_pressed
func set_pressed(value : bool):
	pressed = value
	_texture_button.pressed = value
func get_pressed() -> bool:
	return pressed

var amount : int setget , get_amount
func get_amount():
	if self.item:
		return self.item.amount
	else:
		return 0

var _item := WeakRef.new()

onready var _texture_button := $TextureButton
onready var _amount_label := $AmountLabel

signal item_pressed

func _ready():
	var _error : int = _texture_button.connect("pressed", self, "_on_button_pressed")

	self.item = null

func _on_button_pressed():
	if self.item:
		# Dont change pressed here! This will be done by the overlay instead!
		emit_signal("item_pressed", _texture_button.pressed, self.item)

func _update_amount_label():
	var _amount = self.amount
	_amount_label.text = "{0} x".format([_amount])
	if _amount > 1:
		_amount_label.visible = true
	else:
		_amount_label.visible = false
