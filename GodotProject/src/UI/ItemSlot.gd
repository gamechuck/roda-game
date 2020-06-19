extends TextureRect
class_name class_item_slot

var item_id := ""
var item_count := 0
var pressed : bool = false setget set_pressed, get_pressed

onready var _texture_button = $TextureButton
onready var _count_label = $Node2D/CountLabel

signal pressed

func _ready():
	var _error : int = _texture_button.connect("pressed", self, "_on_button_pressed")
	remove_item()

func empty() -> bool:
	if item_id.empty():
		return true
	else:
		return false

func set_pressed(value : bool):
	pressed = value
	_texture_button.pressed = value

func get_pressed() -> bool:
	return pressed

func _on_button_pressed():
	if not empty():
		pressed = _texture_button.pressed
		emit_signal("pressed", pressed)

func increase_item_count():
	item_count += 1
	_update_count_label()

func decrease_item_count():
	item_count -= 1
	_update_count_label()

	if item_count == 0:
		remove_item()

func add_item(id : String, data : Dictionary):
	item_id = id
	item_count = 1

	var textures : Dictionary = data.get("TEXTURES", {})
	var texture_normal_path : String = textures.get("TEXTURE_NORMAL", Flow.FALLBACK_INVENTORY_TEXTURE)
	var	texture_pressed_path : String = textures.get("TEXTURE_PRESSED", Flow.FALLBACK_INVENTORY_TEXTURE)

	if not ResourceLoader.exists(texture_normal_path):
		texture_normal_path = Flow.FALLBACK_INVENTORY_TEXTURE
	if not ResourceLoader.exists(texture_pressed_path):
		texture_pressed_path = Flow.FALLBACK_INVENTORY_TEXTURE

	_texture_button.texture_normal = load(texture_normal_path)
	_texture_button.texture_pressed = load(texture_pressed_path)

func remove_item():
	item_id = ""
	item_count = 0

	self.pressed = false
	_texture_button.texture_normal = null
	_texture_button.texture_pressed = null
	_update_count_label()

func _update_count_label():
	_count_label.text = "{0} x".format([item_count])
	if item_count > 1:
		_count_label.visible = true
	else:
		_count_label.visible = false
