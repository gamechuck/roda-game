# AudioEngine autoload to easily start/stop sound effects and background music.
extends Node

const MUSIC_TRACKS = {
	"menu_default": preload("res://assets/audio/music/menu_default.ogg"),
	"game_default": preload("res://assets/audio/music/game_default.ogg"),
	"game_smog": preload("res://assets/audio/music/game_smog.ogg")
}

onready var _music_player:= $MusicPlayer

func convert_scale_to_db(scale: float):
	return 20 * log(scale) / log(10)

var background_audio = null

func reset():
	stop_music()

func play_music(key : String) -> void:
	var value : AudioStream = MUSIC_TRACKS[key]
	if _music_player.stream != value:
		_music_player.stream = value
		_music_player.play()

func stop_music() -> void:
	if _music_player.playing:
		_music_player.stop()
		_music_player.stream = null
