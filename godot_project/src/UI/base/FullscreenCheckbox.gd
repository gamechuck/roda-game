extends CheckBox

func _ready():
	# Don't show this option on mobile or web platforms!
	if OS.get_name() in ["Android", "iOS", "HTML5"]:
		visible = false
	else:
		visible = true

		Flow.connect("setting_changed", self, "_on_setting_changed")
		connect("toggled", self, "_on_check_box_toggled")

		update_setting()

func update_setting():
	pressed = OS.window_fullscreen

func _on_setting_changed():
	update_setting()

# TODO: Might be better to change the actual setting in Flow instead?
# (or in another autoload singleton)
func _on_check_box_toggled(button_pressed : bool):
	ConfigData.set_fullscreen(button_pressed)
	Flow.emit_signal("setting_changed")
