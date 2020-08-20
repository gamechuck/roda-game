extends class_projectile

func _ready():
	_timer.wait_time = ConfigData.tracking_ttl
	_timer.start()

func _physics_process(delta : float):
	var direction : Vector2 = Flow.player.global_position - global_position
	direction = direction.normalized()

	global_position += direction*delta*ConfigData.tracking_speed
