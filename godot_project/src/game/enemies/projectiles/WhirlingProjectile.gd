extends class_projectile

#var _angle := 0.0
#var _radius := 0.0
#
#func _ready():
#	_timer.wait_time = ConfigData.whirling_ttl
#	_timer.start()
#
#func _physics_process(delta : float):
#	_angle += 0.01
#	_radius += 0.5
#
#	position = Vector2(sin(_angle), cos(_angle)) * _radius;
