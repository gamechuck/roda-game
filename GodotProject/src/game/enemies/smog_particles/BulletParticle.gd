extends class_smog_particle

var _target_position := Vector2.ZERO

func _ready():
	_target_position = Flow.player.global_position 

func _physics_process(delta : float):
	var direction : Vector2 = _target_position - get_parent().global_position
	direction = direction.normalized()

	global_position += direction*delta*100
