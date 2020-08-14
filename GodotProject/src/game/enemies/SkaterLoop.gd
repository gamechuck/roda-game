tool
extends YSort

onready var _skaters_container := $Skaters

onready var _path_follow_resource := preload("res://src/traffic/PathFollow.tscn")
onready var _skater_resource := preload("res://src/Skater.tscn")
onready var _path_2D := $Path2D

export var points := PoolVector2Array() setget set_points

func set_points(value : PoolVector2Array):
	points = value
	var curve : Curve2D = $Path2D.curve
	curve.clear_points()
	for point in points:
		curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)

	update()

func _ready():
	randomize()

	var curve := Curve2D.new()
	for point in points:
		curve.add_point(point, Vector2.ZERO, Vector2.ZERO)
	# Close the curve!
	if not points.empty():
		curve.add_point(points[0], Vector2.ZERO, Vector2.ZERO)
	_path_2D.curve = curve

	if not Engine.editor_hint:
		for skater in _skaters_container.get_children():
			_skaters_container.remove_child(skater)
			skater.queue_free()
		for path_follow in _path_2D.get_children():
			_path_2D.remove_child(path_follow)
			path_follow.queue_free()

		var _skater : class_skater = spawn_skater(0.0)

func spawn_skater(initial_offset : float) -> class_skater:
	var path_follow : PathFollow2D = _path_follow_resource.instance()
	$Path2D.add_child(path_follow)

	var skater : class_skater = _skater_resource.instance()
	skater.initial_offset = initial_offset
	skater.path_follow = path_follow
	_skaters_container.add_child(skater)
	skater.owner = self

	path_follow.get_node("RemoteTransform2D").remote_path = skater.get_path()
	return skater
