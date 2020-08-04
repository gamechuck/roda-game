extends TabContainer

func _ready():
	for child in get_children():
		if child is class_pause_tab:
			child.connect("button_pressed", self, "_on_button_pressed")

func _on_button_pressed(type : int):
	var index := 0
	for child in get_children():
		if child.tab_type == type:
			child.update_tab()
			current_tab = index
			return
		index += 1
