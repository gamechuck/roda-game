extends classCharacter

func _ready():
	update_animation()

func update_animation():
	var roda_shop_gave_seeds : int = local_variables.get("roda_shop_gave_seeds", 0)
	if roda_shop_gave_seeds:
		set_visible(true)
	else:
		set_visible(false)
