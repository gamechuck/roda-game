extends classCharacter

#var _projectiles_resources := [
#	preload("res://src/game/enemies/projectiles/TrackingProjectile.tscn"),
#	preload("res://src/game/enemies/projectiles/BulletProjectile.tscn"),
#	preload("res://src/game/enemies/projectiles/WhirlingProjectile.tscn")
#]

var future_health := ConfigData.boss_max_health
var health := ConfigData.boss_max_health setget set_health
func set_health(value : float) -> void:
	health = value
	if Flow.boss_overlay:
		Flow.boss_overlay.health = health

func _ready():
	randomize()

	var _error : int = $Timer.connect("timeout", self, "_on_spawn_timer_timeout")

	_error = $InteractArea.connect("body_entered", self, "_on_body_entered")
	_error = $InteractArea.connect("body_exited", self, "_on_body_exited")

	update_animation()
	#_timer.start()
	reset()

func reset():
	# Remove all the still-living particles.
	for child in $Projectiles.get_children():
		$Projectiles.remove_child(child)
		child.queue_free()

	future_health = ConfigData.boss_max_health
	self.health = ConfigData.boss_max_health
	$Timer.stop()

func update_overlay():
	if Flow.boss_overlay:
		Flow.boss_overlay.health = health

func set_monitorable(value : bool = $InteractArea.monitorable):
	$InteractArea.monitorable = value
	if value:
		set_process_input(true)
	else:
		set_process_input(false)

func _on_body_entered(body : PhysicsBody2D):
	if body is classPlayer:
		if get_state_property("is_defeated") == 0:
			Director._on_dialogue_requested(self)
			Director.zoom_camera(Vector2(1.5, 1.5))
			reset()
			yield(Director, "grant_player_autonomy")

			Flow.boss_overlay.show()

			$Timer.start()

func _on_body_exited(body : PhysicsBody2D):
	if body is classPlayer:
		if get_state_property("is_defeated") == 0:
			reset()
			Flow.boss_overlay.hide()
			Director.zoom_camera(Vector2(1, 1))

			$Timer.stop()

func _on_spawn_timer_timeout():
	if future_health > 0:
		if $Projectiles.get_children().size() < 10:
			#var index := rand_range(0, _projectiles_resources.size())
			var projectile = load("res://src/game/enemies/projectiles/BulletProjectile.tscn").instance()
			#var projectile = _projectiles_resources[0].instance()
			$Projectiles.add_child(projectile)
			projectile.owner = $Projectiles

			future_health -= 1

			projectile.connect("projectile_timeout", self, "_on_projectile_timeout")
			#projectile.connect("player_hit", self, "_on_player_hit")
	else:
		$Timer.stop()

func _on_player_hit():
	# Would be better to do this here? For future stuff?
	pass

func _on_projectile_timeout(projectile : classProjectile):
	$Projectiles.remove_child(projectile)
	projectile.queue_free()

	self.health -= 1

	if health <= 0:
		set_state_property("is_defeated", 1)
		Director._on_dialogue_requested(self)
		Director.zoom_camera(Vector2(1, 1))
		Flow.boss_overlay.hide()
		update_animation()

func update_animation():
	var is_defeated : int = get_state_property("is_defeated")
	if is_defeated:
		_animated_sprite.play("is_defeated")

		var shape = _interact_collision_shape_2D.shape
		shape.extents = Vector2(48, 48)

		set_monitorable(true)
		_animated_sprite.material = null
	else:
		_animated_sprite.play("default")

		var shape = _interact_collision_shape_2D.shape
		shape.extents = Vector2(480, 360)

		set_monitorable(false)
		_animated_sprite.material = preload("res://assets/materials/smog_distortion_material.tres")
