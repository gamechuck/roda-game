extends Area2D
class_name class_projectile

onready var _timer := $Timer

signal projectile_timeout()

func _ready():
	var _error := _timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	emit_signal("projectile_timeout", self)
