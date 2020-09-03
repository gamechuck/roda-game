extends Control

onready var _animation_player := $AnimationPlayer

func _ready():
	if ConfigData.skip_menu:
		if ConfigData.verbose_mode : print("Automatically skipping menu as requested by configuration data...")
		Flow.change_scene_to("game")
	else:
		AudioEngine.play_background_music("title")
		_animation_player.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(_anim_name : String):
	Flow.change_scene_to("menu")
