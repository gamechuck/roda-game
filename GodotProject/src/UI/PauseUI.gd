extends Control

onready var _tab_container := $TabContainer

func _ready():
	Flow.pause_UI = self

func show():
	_tab_container.set_current_tab(class_pause_tab.TABS.MAIN)
	visible = true

func hide():
	# Save the user-settings to the local system.
	var _error := ConfigData.save_settingsCFG()
	if _error != OK:
		push_error("Failed to save settings to local storage! Check console for clues!")
	visible = false
