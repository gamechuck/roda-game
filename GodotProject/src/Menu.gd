extends Control

onready var _tab_container := $TabContainer

func _ready():
	AudioEngine.play_background_music("title")
	_tab_container.set_current_tab(class_menu_tab.TABS.MAIN)
