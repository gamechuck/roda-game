extends class_character

enum STATE {IN_CUTSCENE, AGGRESSIVE, DEFEATED}

var _particle_resources := [
	preload("res://src/characters/smog_particles/TrackingParticle.tscn"),
	preload("res://src/characters/smog_particles/BulletParticle.tscn"),
	preload("res://src/characters/smog_particles/WhirlingParticle.tscn")
]

var _health := 100.0
var _state : int = STATE.IN_CUTSCENE 

onready var _particles_container := $Particles
onready var _interact_area := $InteractArea
onready var _timer := $Timer

func _ready():
	var _error : int = _timer.connect("timeout", self, "_on_timer_timeout")

	_error = _interact_area.connect("area_entered", self, "_on_area_entered")
	_error =_interact_area.connect("area_exited", self, "_on_area_exited")

	reset()

func reset():
	_health = ConfigData.boss_max_health
	_timer.start()

func _on_area_entered(area : Area2D):
	var parent = area.get_parent()
	if parent is class_player:
		Flow.boss_overlay.show()
		reset()

func _on_area_exited(area : Area2D):
	var parent = area.get_parent()
	if parent is class_player:
		Flow.boss_overlay.hide()
		_timer.stop()

func _on_timer_timeout():
	if _health > 0:
		var index := rand_range(0, _particle_resources.size())
		#index = 0
		var smog_particle = _particle_resources[index].instance()
		_particles_container.add_child(smog_particle)

		_health -= 1
		Flow.boss_overlay.health = _health
	elif _particles_container.get_children().empty():
		_animated_sprite.animation = "defeated"
		_timer.stop()

var _state_machine := {
	STATE.AGGRESSIVE:{
		"animation_name": "aggressive"
	},
	STATE.DEFEATED:{
		"animation_name": "defeated"
	}
}
