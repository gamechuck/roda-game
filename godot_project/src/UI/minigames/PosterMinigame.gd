extends classMinigame

onready var _clear_button := $VBoxContainer/HBoxContainer/RightVBox/ClearButton
onready var _canvas_rect := $VBoxContainer/HBoxContainer/CanvasRect

onready var _submit_button :=  $VBoxContainer/SubmitButton

var _children := []
var default_background_color : Color

signal submit_button_pressed

func _ready() -> void:
	var _error := _submit_button.connect("pressed", self, "_on_submit_button_pressed")
	_error = connect("submit_button_pressed", Director, "_on_choice_button_pressed")

	_error = _clear_button.connect("pressed", self, "_on_clear_button_pressed")

	_children = $VBoxContainer/HBoxContainer/LeftVBox/SymbolGrid.get_children()
	_children += $VBoxContainer/HBoxContainer/LeftVBox/SloganGrid.get_children()

	for child in _children:
		if child is Button:
			_error = child.connect("pressed", self, "_on_child_button_pressed", [child])

	for child in $VBoxContainer/HBoxContainer/RightVBox/ColorGrid.get_children():
		if child is Button:
			if default_background_color == Color.black:
				default_background_color = child.color
			child.connect("pressed", self, "_on_color_button_pressed", [child.color])

	_on_clear_button_pressed()

func _on_child_button_pressed(button : Button) -> void:
	var pressed : bool = button.pressed

	for child in _children:
		if child is Button:
			if child != button:
				child.pressed = false
			else:
				child.pressed = pressed

				if pressed:
					_canvas_rect.pressed_texture = button.texture
				else:
					_canvas_rect.pressed_texture = null

func _on_color_button_pressed(color : Color) -> void:
	_canvas_rect.background_color = color
	_canvas_rect.update_texture()

func _on_clear_button_pressed() -> void:
	_canvas_rect.background_color = default_background_color
	_canvas_rect.reset_texture()

func _on_submit_button_pressed() -> void:
	if ConfigData.verbose_mode : print("POSTER MINIGAME - done!")

	State.foreground_image = _canvas_rect.foreground_image
	State.background_color = _canvas_rect.background_color

	for billboard in get_tree().get_nodes_in_group("billboards"):
		billboard.update_poster()

	emit_signal("submit_button_pressed", 0)
