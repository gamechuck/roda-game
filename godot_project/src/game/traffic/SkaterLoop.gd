extends Path2D

onready var SCENE_PATH_FOLLOW := preload("res://src/game/base/PathFollow.tscn")
onready var SCENE_SKATER := preload("res://src/game/traffic/Skater.tscn")

var skaters : YSort

func _ready():
	skaters = YSort.new()
	skaters.name = name
	get_node("../../Sorted/Skaters").add_child(skaters)

	for child in get_children():
		remove_child(child)
		child.queue_free()

	set_visible()

func spawn_skater(initial_offset : float) -> classSkater:
	var path_follow : PathFollow2D = SCENE_PATH_FOLLOW.instance()
	add_child(path_follow)

	var skater : classSkater = SCENE_SKATER.instance()
	skater.initial_offset = initial_offset
	skater.path_follow = path_follow
	skaters.add_child(skater)

	path_follow.get_node("RemoteTransform2D").remote_path = skater.get_path()
	return skater

func set_visible(value : bool = visible):
	visible = value
	if visible:
		var _skater : classSkater = spawn_skater(0.0)
	else:
		for child in skaters.get_children():
			skaters.remove_child(child)
			child.queue_free()
		for child in get_children():
			remove_child(child)
			child.queue_free()
