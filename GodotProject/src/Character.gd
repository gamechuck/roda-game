extends StaticBody2D
class_name class_character

onready var _interact_area := $InteractArea
onready var _audio_stream_player := $AudioStreamPlayer

var is_mouse_inside := false

func play_sound_byte():
	_audio_stream_player.play()

	#var _error := _interact_area.connect("input_event", self, "_on_input_event")
	#var _error := _interact_area.connect("mouse_entered", self, "_on_mouse_entered")

func _on_mouse_entered():
	is_mouse_inside = true

func _on_mouse_exited():
	is_mouse_inside = false

#func _input(event):
#	if is_mouse_inside:
#		if event.is_action_pressed("left_mouse_button"):
#			print("clicked on character!")
#			get_tree().set_input_as_handled()
