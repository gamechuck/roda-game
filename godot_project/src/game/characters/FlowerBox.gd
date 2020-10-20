extends classCharacter

var properties := {
	"has_rose_seeds" : 0
}

func _ready():
	for key in properties.keys():
		register_state_property(key, properties[key])

	var shape = _interact_collision_shape_2D.shape
	_interact_collision_shape_2D.shape = shape.duplicate(true)

	update_animation()

func update_animation():
	var has_rose_seeds : int = get_state_property("has_rose_seeds")
	var state_settings : Dictionary = _state_machine.get(has_rose_seeds, {})
	_animated_sprite.play(state_settings.get("animation", "default"))

var _state_machine := {
	0:{
		"animation": "default"
	},
	1:{
		"animation": "has_rose_seeds"
	}
}
