tool
extends MarginContainer
class_name class_menu_tab

enum TABS {MAIN = 0, HOW_TO_PLAY = 1, SETTINGS = 2}
export(TABS) var tab_type := TABS.MAIN setget set_tab_type

# warning-ignore:unused_signal
signal button_pressed(tab_type)

func _ready():
	set("custom_constants/margin_right", 16)
	set("custom_constants/margin_top", 16)
	set("custom_constants/margin_left", 16)
	set("custom_constants/margin_bottom", 16)

func set_tab_type(value : int):
	tab_type = value

func _on_back_button_pressed():
	emit_signal("button_pressed", TABS.MAIN)

func _on_quit_button_pressed():
	Flow.deferred_quit()

func update_tab():
	pass
