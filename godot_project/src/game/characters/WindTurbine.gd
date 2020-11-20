extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var wind_turbine_powered : int = local_variables.get("wind_turbine_powered", 0)
	if wind_turbine_powered:
		_animated_sprite.play("wind_turbine_powered")
	else:
		_animated_sprite.play("default")
