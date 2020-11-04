extends Node2D

onready var _navigation_2D := $Navigation2D
onready var _player := $YSort/Player
onready var _fences := $YSort/Fences

onready var _smog_sprite := $SmogVortex

onready var _copper_blockade_shape := $CopperBlockade/CollisionShape2D

onready var _wheelie := $YSort/Characters/Wheelie
#onready var _dog := $YSort/Characters/Dog

signal level_change_requested

func _ready():
	Flow.game_canvas = self

	var _error := connect("level_change_requested", self, "_on_level_change_requested")

	_wheelie.connect("nav_path_requested", self, "_on_nav_path_requested", [_wheelie])
	#_error = _dog.connect("nav_path_requested", self, "_on_nav_path_requested", [_dog])

#	for ghost in _ghosts.get_children():
#		_error = ghost.connect("nav_path_requested", self, "_on_nav_path_requested", [ghost])

func _on_number_of_fences_fixed(new_value):
	var value := 0
	for fence in _fences.get_children():
		if value < new_value:
			fence.set_visible(true)
		else:
			fence.set_visible(false)
		value += 1

func _on_battery_quest_completed(value : int):
	if value:
		_smog_sprite.visible = false
	else:
		_smog_sprite.visible = true

func _on_player_wearing_color(value : int):
	if value:
		_copper_blockade_shape.disabled = true
	else:
		_copper_blockade_shape.disabled = false
