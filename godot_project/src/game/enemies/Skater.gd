class_name classSkater
extends Area2D

onready var _tween := $Tween

onready var _animated_sprite := $AnimatedSprite

enum VERTICAL {UP, DOWN}
enum HORIZONTAL {LEFT, RIGHT}

var initial_offset := 0.0
var path_follow : PathFollow2D = null

var horizontal_direction : int = VERTICAL.UP
var vertical_direction : int = HORIZONTAL.LEFT

func _ready():
	var parent = path_follow.get_parent()
	if parent is Path2D:
		var curve : Curve2D = parent.curve
		if curve != null:
			var duration : float = curve.get_baked_length()
			if not Engine.editor_hint:
				duration /= ConfigData.skater_move_speed
			else:
				duration /= 1.0
			duration /= ProjectSettings.get("physics/common/physics_fps")

			_tween.interpolate_method(self, "set_unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			_tween.repeat = true
			_tween.seek(initial_offset*duration)
			_tween.start()

func set_unit_offset(value : float):
	var old_position := path_follow.position
	path_follow.unit_offset = value
	var direction : Vector2 = path_follow.position - old_position
	update_state(direction.normalized())

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()

	var old_horizontal : int = horizontal_direction
	var old_vertical : int = vertical_direction

	if normalized_direction.x >= 0.1:
		horizontal_direction = HORIZONTAL.LEFT
	else:
		horizontal_direction = HORIZONTAL.RIGHT

	if normalized_direction.y >= 0.1:
		vertical_direction = VERTICAL.DOWN
	else:
		vertical_direction = VERTICAL.UP

	if old_horizontal != horizontal_direction\
	 or old_vertical != vertical_direction:
		update_animation()

func update_animation():
	var state_settings : Dictionary = state_machine.get(vertical_direction, {})
	state_settings = state_settings.get(horizontal_direction, {})

	_animated_sprite.play(state_settings.get("animation_name", "up_left"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

	$CollisionShape2D.scale = state_settings.get("area_scale", Vector2.ONE)

var state_machine := {
	VERTICAL.UP: {
		HORIZONTAL.LEFT:{
			"animation_name": "up_left"
		},
		HORIZONTAL.RIGHT:{
			"animation_name": "up_right"
		}
	},
	VERTICAL.DOWN: {
		HORIZONTAL.LEFT:{
			"animation_name": "down_left"
		},
		HORIZONTAL.RIGHT:{
			"animation_name": "down_right"
		}
	}
}
