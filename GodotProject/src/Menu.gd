extends Control

onready var _menu_tab_container := $MenuTabContainer

func _ready():
	if ConfigData.skip_menu:
		if ConfigData.verbose_mode : print("Automatically skipping menu as requested by configuration data...")
		Flow.change_scene_to("game")
	else:
		AudioEngine.play_background_music("title")
		_menu_tab_container.set_current_tab(classMenuTab.TABS.MAIN)
