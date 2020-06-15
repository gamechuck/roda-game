extends Control

onready var _tween := $Tween
onready var _color_rect := $ColorRect

const DURATION := 4.0

var eye_is_closed := false

func _ready():
	
	var _error : int = _tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	#_on_tween_all_completed()

func _on_tween_all_completed():
	var initial_value := 0.0
	var final_value := 1.0
	if eye_is_closed:
		initial_value = 1.0
		final_value = 0.0
		eye_is_closed = false
	else:
		eye_is_closed = true
	print("completed")
	_tween.interpolate_method(
		self, 
		"_set_shader_param", 
		initial_value, 
		final_value, 
		DURATION,
		Tween.TRANS_CUBIC, 
		Tween.EASE_IN_OUT)
	_tween.start()

func _set_shader_param(value : float):
	var shader_material : ShaderMaterial = _color_rect.get_material()
	shader_material.set_shader_param("threshold", value)
