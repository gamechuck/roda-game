extends MarginContainer

onready var _health_bar := $VBoxContainer/HealthBar
onready var _label := $VBoxContainer/NameLabel

var health := 0.0 setget set_health
func set_health(value : float):
	health = value
	_health_bar.value = 100.0*health/ConfigData.boss_max_health

func _ready():
	Flow.boss_overlay = self

func show():
	visible = true

func hide():
	visible = false
