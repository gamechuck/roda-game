extends Node2D

onready var _navigation_2D := $Navigation2D
onready var _player := $YSort/Player

func _input(event):
	if not Flow.is_in_editor_mode:
		if event.is_action_pressed("left_mouse_button"):
			var mouse_position := get_local_mouse_position()
			print("Player is navigating to '{0}'".format([mouse_position]))
			_player.nav_path = _navigation_2D.get_simple_path(_player.position, mouse_position)
