class_name classGhost
extends Area2D

enum STATE {SLEEPING, AWAKE}

var nav_path : PoolVector2Array = []

var initial_position := Vector2.ZERO

var _state : int = STATE.SLEEPING 

onready var _animated_sprite := $AnimatedSprite
onready var _cpu_particles_2D := $CPUParticles2D
onready var _visibility_notifier_2D := $VisibilityNotifier2D
onready var _audio_stream_player_2D := $AudioStreamPlayer2D

var _has_reached_target := true

signal nav_path_requested

func _ready():
	initial_position = position

	var _error : int = _visibility_notifier_2D.connect("screen_entered", self, "_on_screen_entered")

func _on_screen_entered():
	set_physics_process(true)

func _physics_process(_delta):
	if not Flow.is_in_editor_mode:

		if not _visibility_notifier_2D.is_on_screen() and _has_reached_target:
			# The ghost can disable it's own physics process since it doesnt need to process.
			set_physics_process(false)

		else:
			var move_direction := Vector2.ZERO
			var move_speed := _get_move_speed()

			if nav_path.size() > 0:
				var distance := position.distance_to(nav_path[0])
				if distance > ConfigData.ghost_awake_move_speed:
					var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
					move_direction = new_position - position
				else:
					nav_path.remove(0)
					if nav_path.empty():
						_has_reached_target = true
					else:
						_has_reached_target = false

			var normalized_direction := move_direction.normalized()
			position += normalized_direction*move_speed

			_update_state()

func _check_activation_condition() -> bool:
	var distance_to_player = position - Flow.player.position
	if distance_to_player.length() > ConfigData.ghost_activation_distance:
		return false

	var facing = Vector2.ZERO
	match Flow.player._direction:
		classPlayer.DIRECTION.LEFT:
			facing = Vector2.LEFT
		classPlayer.DIRECTION.RIGHT:
			facing = Vector2.RIGHT
		classPlayer.DIRECTION.UP:
			facing = Vector2.UP
		classPlayer.DIRECTION.DOWN:
			facing = Vector2.DOWN
	if acos(distance_to_player.normalized().dot(facing)) < deg2rad(90):
		return false
	else:
		return true

func _get_move_speed() -> float:
	match _state:
		STATE.AWAKE:
			return ConfigData.ghost_awake_move_speed
		STATE.SLEEPING, _:
			return ConfigData.ghost_sleeping_move_speed

func _update_state():
	var old_state : int = _state

	if _check_activation_condition():
		_state = STATE.AWAKE
		emit_signal("nav_path_requested", Flow.player.position)
	else:
		_state = STATE.SLEEPING
		emit_signal("nav_path_requested", initial_position)

	if old_state != _state:
		_update_animation()

func _update_animation():
	var state_settings : Dictionary = _state_machine.get(_state, {})
	_animated_sprite.play(state_settings.get("animation_name", "sleeping"))

	_cpu_particles_2D.emitting = state_settings.get("emitting", false)

	_audio_stream_player_2D.playing = state_settings.get("playing", false)

var _state_machine := {
	STATE.SLEEPING:{
		"animation_name": "sleeping",
		"emitting": true,
		"playing": true 
	},
	STATE.AWAKE:{
		"animation_name": "awake",
		"emitting": false,
		"playing": false 
	}
}
