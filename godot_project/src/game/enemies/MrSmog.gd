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

onready var _projectiles_container := $Projectiles
onready var _interact_area := $InteractArea
onready var _spawn_timer := $Timer
onready var _tween := $Tween

func _ready():
	randomize()

	var _error : int = _spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")

	_error = _interact_area.connect("body_entered", self, "_on_body_entered")
	_error = _interact_area.connect("body_exited", self, "_on_body_exited")

	update_animation()
	#_timer.start()
	reset()

func reset():
	# Remove all the still-living particles.
	for child in _projectiles_container.get_children():
		_projectiles_container.remove_child(child)
		child.queue_free()

	future_health = ConfigData.boss_max_health
	self.health = ConfigData.boss_max_health
	_spawn_timer.stop()

func update_overlay():
	if Flow.boss_overlay:
		Flow.boss_overlay.health = health

func set_monitorable(value : bool = _interact_area.monitorable):
	_interact_area.monitorable = value
	if _interact_area.monitorable:
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

			_spawn_timer.start()

func _on_body_exited(body : PhysicsBody2D):
	if body is classPlayer:
		if get_state_property("is_defeated") == 0:
			reset()
			Flow.boss_overlay.hide()
			Director.zoom_camera(Vector2(1, 1))

			_spawn_timer.stop()

func _on_spawn_timer_timeout():
	if future_health > 0:
		if _projectiles_container.get_children().size() < 10:
			#var index := rand_range(0, _projectiles_resources.size())
			var projectile = load("res://src/game/enemies/projectiles/BulletProjectile.tscn").instance()
			#var projectile = _projectiles_resources[0].instance()
			_projectiles_container.add_child(projectile)
			projectile.owner = _projectiles_container

			future_health -= 1

			projectile.connect("projectile_timeout", self, "_on_projectile_timeout")
			#projectile.connect("player_hit", self, "_on_player_hit")
	else:
		_spawn_timer.stop()

func _on_player_hit():
	# Would be better to do this here? For future stuff?
	pass

func _on_projectile_timeout(projectile : classProjectile):
	_projectiles_container.remove_child(projectile)
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
