extends Path2D

onready var _tween := $Tween
onready var _path_follow := $PathFollow2D

func _ready():
	_tween.interpolate_property(_path_follow, "unit_offset", 0, 1, 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.repeat = true
	_tween.start()
