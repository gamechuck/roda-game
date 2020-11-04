tool
class_name classWaypoint
extends Sprite

export(String) var id setget set_id
func set_id(value : String) -> void:
	id = value
	if is_inside_tree():
		$Label.text = id

func _ready():
	if not Engine.editor_hint:
		add_to_group("waypoints")

	$Label.text = id
