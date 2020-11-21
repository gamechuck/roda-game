extends Control

onready var _pause_tab_container := $PauseTabContainer

func _ready():
	var _error : int = Flow.connect("pause_toggled", self, "_on_pause_toggled")

func _on_pause_toggled():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		show()
	else:
		hide()

func show():
	_pause_tab_container.set_current_tab(classPauseTab.TABS.MAIN)
	visible = true

func hide():
	# Save the user-settings to the local system.
	# Under the condition that the current tab was the settings one.
	if _pause_tab_container.get_current_tab() == classPauseTab.TABS.SETTINGS:
		var _error := ConfigData.save_settingsCFG()
		if _error != OK:
			push_error("Failed to save settings to local storage! Check console for clues!")
	visible = false
