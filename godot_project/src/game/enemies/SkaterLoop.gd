extends YSort

onready var _skaters_container := $Skaters

onready var _path_follow_resource := preload("res://src/game/base/PathFollow.tscn")
onready var _skater_resource := preload("res://src/game/enemies/Skater.tscn")
onready var _path_2D := $Path2D

func _ready():
	for skater in _skaters_container.get_children():
		_skaters_container.remove_child(skater)
		skater.queue_free()
	for path_follow in _path_2D.get_children():
		_path_2D.remove_child(path_follow)
		path_follow.queue_free()

	set_visible()

func spawn_skater(initial_offset : float) -> classSkater:
	var path_follow : PathFollow2D = _path_follow_resource.instance()
	$Path2D.add_child(path_follow)

	var skater : classSkater = _skater_resource.instance()
	skater.initial_offset = initial_offset
	skater.path_follow = path_follow
	_skaters_container.add_child(skater)
	skater.owner = self

	path_follow.get_node("RemoteTransform2D").remote_path = skater.get_path()
	return skater

func set_visible(value : bool = visible):
	visible = value
	if visible:
		var _skater : classSkater = spawn_skater(0.0)
	else:
		for skater in _skaters_container.get_children():
			_skaters_container.remove_child(skater)
			skater.queue_free()
		for path_follow in _path_2D.get_children():
			_path_2D.remove_child(path_follow)
			path_follow.queue_free()
