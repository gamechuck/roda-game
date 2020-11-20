extends Control

onready var _tween := $Tween
onready var _color_rect := $ColorRect

signal transition_completed()

enum TRANSITION {OPAQUE, TRANSPARENT}

var _transition_stack := []
var _duration := 1.0

func _ready():
	Flow.transitions_UI = self

	var _error : int = _tween.connect("tween_all_completed", self, "_on_tween_all_completed")

	visible = false

func fade_to_opaque(duration : float = 2.0):
	visible = true
	_tween.interpolate_method(
		self,
		"_set_shader_param",
		1.0,
		0.0,
		duration,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT)
	_tween.start()

func fade_to_transparent(duration : float = 2.0):
	visible = true
	_tween.interpolate_method(
		self,
		"_set_shader_param",
		0.0,
		1.0,
		duration,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT)
	_tween.start()

func _on_tween_all_completed():
	print("completed transition!!!")
	if _transition_stack.empty():
		print("completed transition!!!")
		emit_signal("transition_completed")
		var shader_material : ShaderMaterial = _color_rect.get_material()
		if shader_material.get_shader_param("threshold") == 1:
			visible = false
		else:
			visible = true
	else:
		var state : int = _transition_stack.pop_front()
		match state:
			TRANSITION.OPAQUE:
				fade_to_opaque(_duration)
			TRANSITION.TRANSPARENT:
				fade_to_transparent(_duration)

func _set_shader_param(value : float):
	var shader_material : ShaderMaterial = _color_rect.get_material()
	shader_material.set_shader_param("threshold", value)
