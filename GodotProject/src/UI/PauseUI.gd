extends Control

onready var _tab_container := $TabContainer

func _ready():
	Flow.pause_UI = self

func show():
	_tab_container.current_tab = 0
	visible = true

func hide():
	visible = false
