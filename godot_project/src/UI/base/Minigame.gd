class_name classMinigame
extends Control

export(String) var id := ""

func _ready():
	add_to_group("minigames")

func show():
	visible = true

func hide():
	visible = false
