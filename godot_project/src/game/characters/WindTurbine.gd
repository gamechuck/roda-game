extends classCharacter

enum POWER {EMPTY, FULL}

func _ready():
	register_state_property("is_powered", POWER.EMPTY)

func update_animation():
	var has_battery : int = get_state_property("has_battery")
	if has_battery:
		_animated_sprite.play("fixed")
	else:
		_animated_sprite.play("broken")

var _state_machine := {
	POWER.EMPTY:{
		"animation_name": "broken"
	},
	POWER.FULL:{
		"animation_name": "fixed"
	}
}
