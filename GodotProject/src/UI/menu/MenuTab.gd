extends MarginContainer
class_name classMenuTab

enum TABS {MAIN = 0, HOW_TO_PLAY = 1, ABOUT = 2, SETTINGS = 3}
export(TABS) var tab_type := TABS.MAIN setget set_tab_type
func set_tab_type(value : int):
	tab_type = value

# warning-ignore:unused_signal
signal button_pressed(tab_type)

func _on_back_button_pressed():
	emit_signal("button_pressed", TABS.MAIN)

func _on_quit_button_pressed():
	Flow.deferred_quit()

func update_tab():
	pass
