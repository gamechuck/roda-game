extends Control

onready var _game_canvas : = $ViewportContainer/GameCanvas

onready var _editor_camera := $EditorCamera
onready var _game_camera := _game_canvas.get_node("YSort/Player/GameCamera")

func _ready():
	randomize()

	propagate_call("update")

	_editor_camera.current = Flow.is_in_editor_mode
	_game_camera.current = not Flow.is_in_editor_mode

	Flow.load_data()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_mode"):
		Flow.is_in_editor_mode = not Flow.is_in_editor_mode

		_editor_camera.current = Flow.is_in_editor_mode
		_game_camera.current = not Flow.is_in_editor_mode

		get_tree().set_input_as_handled()
