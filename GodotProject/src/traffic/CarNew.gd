tool
extends PathFollow2D
class_name class_car_new

onready var _tween := $Tween
onready var _interact_area := $InteractArea 

var initial_offset := 0.0
var curve_length := 0.0

signal next_car_is_moving

func _ready():
	var _error : int = _interact_area.connect("area_shape_entered", self, "_on_area_shape_entered")
	_error = _interact_area.connect("area_shape_exited", self, "_on_area_shape_exited")

	_tween.interpolate_property(self, "unit_offset", 0, 1, 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.repeat = true
	_tween.seek(initial_offset*10)
	_tween.start()

func _on_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area is class_zebra_crossing_new:
		if area.player_is_inside:
			_tween.stop_all()
			area.connect("player_exited_zebra", self, "_start_moving_again", [], CONNECT_ONESHOT)
	if area is class_car_interact_area:
		var next_car : class_car_new = area.get_parent()
		# compare the distance along the curve!

		if next_car.offset > offset:
			_tween.stop_all()
			next_car.connect("next_car_is_moving", self, "_start_moving_again", [], CONNECT_ONESHOT)

func _start_moving_again():
	_tween.resume_all()
	if is_inside_tree():
		yield(get_tree().create_timer(1), "timeout")
		emit_signal("next_car_is_moving")

func _on_area_shape_exited(_area_id, area, _area_shape, _self_shape):
	print("exited")
