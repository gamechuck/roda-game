extends Control

var _level_flow := {
	"intro": {
		"packed_scene": preload("res://src/game/levels/IntroLevel.tscn"),
		"state": State.LEVEL.INTRO
		},
	"main": {
		"packed_scene": preload("res://src/game/levels/MainLevel.tscn"),
		"state": State.LEVEL.MAIN
		},
	"outro": {
		"packed_scene": preload("res://src/game/levels/OutroLevel.tscn"),
		"state": State.LEVEL.OUTRO
		}
	}
var smog_material := preload("res://assets/materials/smog_fog_material.tres")

func _ready():
	AudioEngine.play_music("game_default")

	var _error := Director.connect("change_level_requested", self, "change_level")

	Flow.load_story()

	if ConfigData.skip_intro or Flow.level_number == 2:
		if ConfigData.skip_main:
			change_level("outro")
		else:
			change_level("main")
	else:
		change_level("intro")

	update_game()

func update_game():
	# Set the current camera to the editor one if editor mode is enabled.
	# Setting a camera to true automatically forces all others to false.
	$EditorCamera.is_active = Flow.is_in_editor_mode
	$GameCamera.is_active = not Flow.is_in_editor_mode

func change_level(key : String) -> void:
	if _level_flow.has(key):
		var state_settings : Dictionary = _level_flow[key]
		var packed_scene : PackedScene = state_settings.packed_scene
		State.level_state = state_settings.state

		# Properly reset the smog material's parameters!
		smog_material.set_shader_param("amount", 0)

		for child in $ViewportContainer.get_children():
			if child is classLevel:
				$ViewportContainer.remove_child(child)
				child.queue_free()

		var level : classLevel = packed_scene.instance()
		$ViewportContainer.add_child(level)

		var error := OK
		#var error := get_tree().change_scene_to(packed_scene)
		if error != OK:
			push_error("Failed to change level to '{0}'.".format([key]))
		else:
			print("Succesfully changed level to '{0}'.".format([key]))
	else:
		push_error("Requested level '{0}' was not recognized... ignoring call for changing scene.".format([key]))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_editor_mode"):
		Flow.is_in_editor_mode = not Flow.is_in_editor_mode

		update_game()
		# Needs to be set as handled to avoid triggering player interactions!
		get_tree().set_input_as_handled()
