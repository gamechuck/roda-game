extends Control

onready var _menu_tab_container := $MenuTabContainer

func _ready():
	# Skip this menu if requested by the default_options.cfg!
	if ConfigData.skip_menu and Flow._game_state == Flow.STATE.STARTUP:
		if ConfigData.verbose_mode : print("Automatically skipping menu as requested by configuration data...")
		Flow.change_scene_to("game")
	else:
		_menu_tab_container.set_current_tab(classMenuTab.TABS.MAIN)
		AudioEngine.play_music("menu_default")
