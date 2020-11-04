class_name classLevel
extends Node2D

# warning-ignore:unused_signal
signal dialogue_requested
# warning-ignore:unused_signal
signal cutscene_requested

func _ready():
	Flow.level = self

	var _error := $Sorted/Player.connect("nav_path_requested", self, "_on_player_nav_path_requested")

	_error = connect("dialogue_requested", Director, "_on_dialogue_requested")
	_error = connect("cutscene_requested", Director, "_on_cutscene_requested")

	AudioEngine.play_music("game_default")

	# Reset the Camera!
	var game_camera : Camera2D = Flow.game_camera

	game_camera.track_player = true
	game_camera.zoom = Vector2(1, 1)
	game_camera.position = Vector2.ZERO

	$Waypoints.visible = ConfigData.DEBUG_SHOW_WAYPOINTS

func _on_player_nav_path_requested():
	var end := get_local_mouse_position()

	_on_nav_path_requested(end, $Sorted/Player)

func _on_nav_path_requested(end : Vector2, node : Node2D):
	var start : Vector2 = node.position

	var nav_path = $Navigation2D.get_simple_path(start, end)
	# Remove the first point since it is the initial position!!!
	nav_path.remove(0)
	node.nav_path = nav_path
