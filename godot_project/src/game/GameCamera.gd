extends Camera2D

var is_active : bool setget set_is_active, get_is_active
func set_is_active(value : bool)-> void:
	current = value
	update_camera()
func get_is_active() -> bool:
	return current

var track_player := true setget set_track_player
func set_track_player(value : bool) -> void:
	track_player = value
	update_camera()

var player : classPlayer

func _ready():
	Flow.game_camera = self

	set_physics_process(false)

func update_camera():
	if track_player and current:
		set_physics_process(true)
	else:
		set_physics_process(false)

func _physics_process(_delta : float) -> void:
	if not player:
		player = Flow.player

	position = player.position
