extends PanelContainer
class_name class_item_slot

var is_empty := true
var item_id := ""
var item_count := 0

var _is_being_dragged := false
var _mouse_offset := Vector2.ZERO

onready var _sprite = $Sprite

func _ready():
	_sprite.texture = null

func add_item(id : String, data : Dictionary):
	item_id = id

	var texture_path : String = data.get("INVENTORY_TEXTURE", Flow.FALLBACK_INVENTORY_TEXTURE)
	var texture_exists : bool = ResourceLoader.exists(texture_path)
	if not texture_exists:
		texture_path = Flow.FALLBACK_INVENTORY_TEXTURE
	_sprite.texture = load(texture_path)

	is_empty = false

func _gui_input(event):
	if is_empty:
		return

	if _is_being_dragged:
		if event.is_action_released("left_mouse_button"):
			_is_being_dragged = false
			#Flow.item_being_dragged = null
	elif event.is_action_pressed("left_mouse_button"):
		_is_being_dragged = true
		Flow.item_being_dragged = self
		_mouse_offset = get_local_mouse_position()
		set_process(true)

func _process(_delta):
	if _is_being_dragged:
		_sprite.position = get_local_mouse_position() - _mouse_offset
	else:
		_sprite.position = Vector2.ZERO
		set_process(false)
