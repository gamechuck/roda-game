extends class_character

enum BATTLE_STATUS {OFFENSIVE, DEFEATED}

var _attacking_player := false

#var _projectiles_resources := [
#	preload("res://src/game/enemies/projectiles/TrackingProjectile.tscn"),
#	preload("res://src/game/enemies/projectiles/BulletProjectile.tscn"),
#	preload("res://src/game/enemies/projectiles/WhirlingProjectile.tscn")
#]

var health := 10.0 setget set_health
func set_health(value : float):
	health = value
	if Flow.boss_overlay:
		Flow.boss_overlay.health = value

onready var _projectiles_container := $Projectiles
onready var _interact_area := $InteractArea
onready var _timer := $Timer
onready var _tween := $Tween

func _ready():
	randomize()
	register_state_property("is_defeated", BATTLE_STATUS.OFFENSIVE)

	var _error : int = _timer.connect("timeout", self, "_on_timer_timeout")

	_error = _interact_area.connect("area_entered", self, "_on_area_entered")
	_error = _interact_area.connect("area_exited", self, "_on_area_exited")

	update_animation()
	#_timer.start()
	reset()

func reset():
	# Remove all the still-living particles.
	for child in _projectiles_container.get_children():
		_projectiles_container.remove_child(child)
		child.queue_free()

	self.health = ConfigData.boss_max_health
	_timer.stop()

func set_monitorable(value : bool = _interact_area.monitorable):
	_interact_area.monitorable = value
	if _interact_area.monitorable:
		set_process_input(true)
	else:
		set_process_input(false)

func _on_area_entered(area : Area2D):
	if not area:
		return
	
	if area.get_parent() is class_player:
		if get_state_property("is_defeated") == BATTLE_STATUS.OFFENSIVE:
			Director._on_dialogue_requested(self)
			Director.zoom_camera(Vector2(1.5, 1.5))
			reset()
			yield(Director, "grant_player_autonomy")

			Flow.boss_overlay.show()

			_timer.start()

func _on_area_exited(area : Area2D):
	if not area:
		return

	if area.get_parent() is class_player:
		if get_state_property("is_defeated") == BATTLE_STATUS.OFFENSIVE:
			reset()
			Flow.boss_overlay.hide()
			Director.zoom_camera(Vector2(1, 1))
			
			_timer.stop()

func _on_timer_timeout():
	if _projectiles_container.get_children().size() < 10:
		#var index := rand_range(0, _projectiles_resources.size())
		var projectile = load("res://src/game/enemies/projectiles/BulletProjectile.tscn").instance()
		#var projectile = _projectiles_resources[0].instance()
		_projectiles_container.add_child(projectile)
		projectile.owner = _projectiles_container

		projectile.connect("projectile_timeout", self, "_on_projectile_timeout")
		#projectile.connect("player_hit", self, "_on_player_hit")

func _on_player_hit():
	pass

func _on_projectile_timeout():
	self.health -= 1

	if health <= 0:
		set_state_property("is_defeated", 1)
		Director._on_dialogue_requested(self)
		Director.zoom_camera(Vector2(1, 1))
		Flow.boss_overlay.hide()
		update_animation()

func update_animation():
	var is_defeated : int = get_state_property("is_defeated")
	var state_settings : Dictionary = _state_machine.get(is_defeated, {})
	_animated_sprite.play(state_settings.get("animation_name", "aggressive"))

	var shape = _interact_collision_shape_2D.shape
	shape.extents = state_settings.get("extents", Vector2(24, 24))

	set_monitorable(state_settings.get("monitorable", false))

var _state_machine := {
	BATTLE_STATUS.OFFENSIVE:{
		"animation_name": "aggressive",
		"extents": Vector2(480, 360),
		"monitorable": false
	},
	BATTLE_STATUS.DEFEATED:{
		"animation_name": "friendly",
		"extents": Vector2(48, 48),
		"monitorable": true
	}
}
