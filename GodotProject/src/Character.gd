extends StaticBody2D
class_name class_character

onready var _interact_area := $InteractArea
onready var _audio_stream_player := $AudioStreamPlayer

func play_sound_byte():
	_audio_stream_player.play()
