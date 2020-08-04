extends class_smog_particle

func _ready():
	pass # Replace with function body.

func _physics_process(delta : float):
	var direction : Vector2 = Flow.player.global_position - global_position
	direction = direction.normalized()

	global_position += direction*delta*50
