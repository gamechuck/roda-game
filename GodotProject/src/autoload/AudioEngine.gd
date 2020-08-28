"""
Audio Engine
"""
extends Node

const tracks = {
	"title": "res://audio/Roda_Main_Menu.ogg",
	"gameplay": "res://audio/Roda_Gameplay.ogg",
	"smog_gameplay": "res://audio/Roda_Smog_Gameplay.ogg"
}

onready var background_player: AudioStreamPlayer = get_node("BackgroundPlayer")

func convert_scale_to_db(scale: float):
	return 20 * log(scale) / log(10)

var background_audio = null

func reset():
	stop_background_music()

func play_background_music(track_name: String):
	var track_path = tracks[track_name]
	"""Initiates a track to play as background music"""
	if background_audio != track_path:
		background_audio = track_path
		background_player.stream = load(track_path)
		background_player.play()

func stop_background_music():
	"""Stops the background music track"""
	if background_player.playing:
		background_player.stop()
		background_audio = null
