extends TileMap

func _ready():
	set_visible()

func set_visible(value : bool = visible):
	visible = value
	if visible:
		if ConfigData.verbose_mode: print("Enabling '{0}' tilemap collision...".format([name]))
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
	else:
		if ConfigData.verbose_mode: print("Disabling '{0}' tilemap collision...".format([name]))
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
