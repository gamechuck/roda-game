extends Control

onready var _game_canvas : = $ViewportContainer/GameCanvas

onready var _editor_camera := $EditorCamera
onready var _game_camera := _game_canvas.get_node("YSort/Player/GameCamera")

func _ready():
	randomize()

	_editor_camera.current = Flow.is_in_editor_mode
	_game_camera.current = not Flow.is_in_editor_mode

	Flow.load_story()
	print("----- Showing output log -----")

	# Start the introduction cutscene
#	for character in get_tree().get_nodes_in_group("characters"):
#		if character.id == "solid_snejk":
#			Flow.dialogue_UI.start_interact_dialogue(character)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_editor_mode"):
		Flow.is_in_editor_mode = not Flow.is_in_editor_mode

		_editor_camera.current = Flow.is_in_editor_mode
		_game_camera.current = not Flow.is_in_editor_mode

		get_tree().set_input_as_handled()
