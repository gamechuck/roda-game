extends Area2D
class_name class_smog_particle

onready var _timer := $Timer

func _ready():
	set_process(true)

	var _error := _timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	get_parent().remove_child(self)
	queue_free()
