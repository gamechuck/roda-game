extends Control

onready var _menu_tab_container := $MenuTabContainer

func _ready():
	AudioEngine.play_background_music("title")
	_menu_tab_container.set_current_tab(classMenuTab.TABS.MAIN)
