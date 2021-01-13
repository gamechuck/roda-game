extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var wind_turbine_powered : int = local_variables.get("wind_turbine_powered", 0)
	if wind_turbine_powered:
		_animated_sprite.play("battery_inserted")
	else:
		_animated_sprite.play("default")
