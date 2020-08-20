extends class_projectile

#var _direction := Vector2.ZERO
#
#func _ready():
#	_timer.wait_time = ConfigData.bullet_ttl
#	_timer.start()
#
#	var player_position : Vector2 = Flow.player.global_position
#	_direction = player_position - get_parent().global_position
#	_direction = _direction.normalized()
#
#func _physics_process(delta : float):
#	global_position += _direction*delta*ConfigData.bullet_speed
