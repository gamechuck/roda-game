extends class_character

var _particle_resources := [
	preload("res://src/characters/particles/TrackingParticle.tscn"),
	preload("res://src/characters/particles/BulletParticle.tscn"),
	preload("res://src/characters/particles/WhirlingParticle.tscn")
]

var _health := 100

onready var _particles_container := $Particles
onready var _timer := $Timer

func _ready():
	var _error : int = _timer.connect("timeout", self, "_on_timer_timeout")
	
	_timer.start()

func _on_timer_timeout():
	var index := rand_range(0, _particle_resources.size())
	#index = 0
	var smog_particle = _particle_resources[index].instance()

	_particles_container.add_child(smog_particle)
