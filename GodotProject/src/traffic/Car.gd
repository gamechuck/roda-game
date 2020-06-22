tool
extends PathFollow2D
class_name class_car

onready var _tween := $Tween
onready var _timer := $Timer

onready var _animated_sprite := $AnimatedSprite
onready var _interact_area := $InteractArea

enum STATE {INITIAL, LEFT, RIGHT, UP, DOWN}

var frames_resources := [
	"res://resources/cars/GreenCar.tres",
	"res://resources/cars/RedCar.tres",
	"res://resources/cars/PurpleCar.tres",
	"res://resources/cars/BlueCar.tres"
]

var car_state : int = STATE.INITIAL
var next_car : PathFollow2D = null

var initial_offset := 0.0
var traffic_loop : YSort = null 

func _ready():

	# Choose a random color for our car!
	var index = randi() % frames_resources.size()
	_animated_sprite = $AnimatedSprite
	_animated_sprite.frames = load(frames_resources[index])

	_timer.wait_time = 0.5
	_timer.one_shot = true

	var _error : int = _interact_area.connect("area_shape_entered", self, "_on_area_shape_entered")
	_error = _interact_area.connect("area_shape_exited", self, "_on_area_shape_exited")
	_error = _timer.connect("timeout", self, "_on_timer_timeout")

	var parent = get_parent()
	if parent is Path2D:
		var curve : Curve2D = get_parent().curve
		if curve != null:
			var duration : float = curve.get_baked_length()
			if not Engine.editor_hint:
				duration /= Flow.CAR_MOVE_SPEED
			else:
				duration /= 1.0
			duration /= ProjectSettings.get("physics/common/physics_fps")

			_tween.interpolate_method(self, "set_unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			_tween.repeat = true
			_tween.seek(initial_offset*duration)
			_tween.start()

func set_unit_offset(value : float):
	var old_position := position
	unit_offset = value
	var direction : Vector2 = position - old_position
	update_state(direction.normalized())

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	var parent = area.get_parent()
	if parent == next_car:
		_tween.stop_all()
	if parent is class_zebra_crossing:
		if parent.has_traffic_lights:
			if parent.light_color == Flow.LIGHT_COLOR.GREEN:
				_tween.stop_all()
				parent.connect("movement_is_allowed", _timer, "start", [], CONNECT_ONESHOT)
		else:
			if parent.player_is_inside:
				_tween.stop_all()
				parent.connect("movement_is_allowed", _timer, "start", [], CONNECT_ONESHOT)

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	var parent = area.get_parent()
	if parent == next_car:
		_timer.start()

func _on_timer_timeout():
	_tween.resume_all()

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()

	var old_state : int = car_state
	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			car_state = STATE.RIGHT
		elif normalized_direction.x < 0:
			car_state = STATE.LEFT
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			car_state = STATE.DOWN
		elif normalized_direction.y < 0:
			car_state = STATE.UP

	if old_state != car_state:
		update_animation()

func update_animation():
	var state_settings : Dictionary = state_machine.get(car_state, {})
	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	_animated_sprite.flip_v = state_settings.get("flip_v", false)

	$InteractArea.scale = state_settings.get("area_scale", Vector2.ONE)

var state_machine := {
	STATE.LEFT:{
		"animation_name": "left"
	},
	STATE.RIGHT:{
		"animation_name": "left",
		"flip_h": true,
		"is_horizontal": true
	},
	STATE.UP:{
		"animation_name": "up",
		"rotation_degrees": 90,
		"is_horizontal": false,
		"area_scale": Vector2(0.4, 1.75)
	},
	STATE.DOWN:{
		"animation_name": "down",
		"rotation_degrees": 90,
		"is_horizontal": false,
		"area_scale": Vector2(0.4, 1.75)
	}
}
