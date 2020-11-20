class_name classCar
extends Area2D

enum STATE {INITIAL, LEFT, RIGHT, UP, DOWN}
const FRAMES_RESOURCES := [
	"res://assets/sprite_frames/cars/green_car.tres",
	"res://assets/sprite_frames/cars/red_car.tres",
	"res://assets/sprite_frames/cars/purple_car.tres",
	"res://assets/sprite_frames/cars/blue_car.tres"
]

var car_state : int = STATE.INITIAL

var initial_offset := 0.0
var path_follow : PathFollow2D = null

var next_car : Area2D = null

func _ready():

	# Choose a random color for our car!
	var index = randi() % FRAMES_RESOURCES.size()
	$AnimatedSprite.frames = load(FRAMES_RESOURCES[index])

	$Timer.wait_time = 0.5
	$Timer.one_shot = true

	var _error : int = connect("area_entered", self, "_on_area_entered")
	_error = connect("area_exited", self, "_on_area_exited")
	_error = $Timer.connect("timeout", self, "_on_timer_timeout")

	var parent = path_follow.get_parent()
	if parent is Path2D:
		var curve : Curve2D = parent.curve
		if curve != null:
			var duration : float = curve.get_baked_length()
			duration /= ConfigData.CAR_MOVE_SPEED

			$Tween.interpolate_method(self, "set_unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.repeat = true
			$Tween.seek(initial_offset*duration)
			$Tween.start()

func set_unit_offset(value : float):
	var old_position := path_follow.position
	path_follow.unit_offset = value
	var direction : Vector2 = path_follow.position - old_position
	update_state(direction.normalized())

func _on_area_entered(area : Area2D):
	if area == next_car:
		$Tween.stop_all()
	if area is classZebraCrossing:
		if area.has_traffic_lights:
			if area.light_color == ConfigData.LIGHT_COLOR.GREEN:
				$Tween.stop_all()
				var _error : int = area.connect("movement_is_allowed", $Timer, "start", [], CONNECT_ONESHOT)
		else:
			if area.player_is_inside:
				$Tween.stop_all()
				var _error : int = area.connect("movement_is_allowed", $Timer, "start", [], CONNECT_ONESHOT)

func _on_area_exited(area : Area2D):
	if area == next_car and $Timer.is_inside_tree():
		$Timer.start()

func _on_timer_timeout():
	$Tween.resume_all()

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
	$AnimatedSprite.play(state_settings.get("animation_name", "default"))
	$AnimatedSprite.flip_h = state_settings.get("flip_h", false)
	$AnimatedSprite.flip_v = state_settings.get("flip_v", false)

	$CollisionShape2D.scale = state_settings.get("area_scale", Vector2.ONE)

var state_machine := {
	STATE.LEFT:{
		"animation_name": "left"
	},
	STATE.RIGHT:{
		"animation_name": "left",
		"flip_h": true
	},
	STATE.UP:{
		"animation_name": "up",
		"area_scale": Vector2(0.4, 1.75)
	},
	STATE.DOWN:{
		"animation_name": "down",
		"area_scale": Vector2(0.4, 1.75)
	}
}
