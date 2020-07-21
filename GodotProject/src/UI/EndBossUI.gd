extends Control

onready var _panel_container := $MarginContainer/VBoxContainer/PanelContainer

func _physics_process(delta):
	pass
	#warp_inside_panel()

func warp_inside_panel():
	var mouse_position = get_global_mouse_position()
	var panel_rect = _panel_container.get_rect()
	if panel_rect.has_point(mouse_position):
		return
	else:
		get_viewport().warp_mouse(Vector2(250, 150))
