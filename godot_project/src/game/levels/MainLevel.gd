extends classLevel

var number_of_fences_fixed := 0 setget set_number_of_fences_fixed
func set_number_of_fences_fixed(value : int) -> void:
	number_of_fences_fixed = value
	var index := 0
	for child in $Sorted/Fences.get_children():
		if index < number_of_fences_fixed:
			child.set_visible(true)
		else:
			child.set_visible(false)
		index += 1

var battery_quest_completed := 0 setget set_battery_quest_completed
func set_battery_quest_completed(value : int) -> void:
	battery_quest_completed = value
	if battery_quest_completed:
		$Vortex.visible = false
	else:
		$Vortex.visible = true

var player_wearing_color := 0 setget set_player_wearing_color
func set_player_wearing_color(value : int) -> void:
	player_wearing_color = value
	if player_wearing_color:
		pass
		#_copper_blockade_shape.disabled = true
	else:
		pass
		#_copper_blockade_shape.disabled = false

func _ready():
	var dog : classCharacter = $Sorted/Characters/Dog
	var _error := dog.connect("nav_path_requested", self, "_on_nav_path_requested", [dog])

	var solid_snejk := $Sorted/Characters/SolidSnejk

	emit_signal("dialogue_requested", solid_snejk)
