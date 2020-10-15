extends Reference
class_name class_pickup_state

var id := ""
var visible := true
# The actual visual representation of this state.
var object : CollisionObject2D = null 

var context : Dictionary setget set_context, get_context
func set_context(value : Dictionary) -> void:
	if not value.has("id"):
		push_error("Pickup context requires id!")
		return

	id = value.id
	visible = value.get("visible", true)

func get_context() -> Dictionary:
	var _context := {}

	# Only save the pickup to the context if it is NOT visible!
	if not visible:
		_context.id = id
		_context.visible = true

	return _context

# These are all constants derived from data.JSON and should be treated as such!
var item_id : String setget , get_item_id
func get_item_id():
	return Flow.get_pickup_value(id, "item_id", "MISSING NAME")

var knot : String setget , get_knot
func get_knot():
	return Flow.get_pickup_value(id, "knot", "MISSING KNOT")
