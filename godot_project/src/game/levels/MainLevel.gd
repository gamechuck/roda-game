extends classLevel

var variable_keys := ["number_of_fences_fixed", "wind_turbine_powered", "player_wearing_color"]
var local_variables := {}

func _ready():
	# Connect to the story!
	var story : Reference = Director.story

	for key in variable_keys:
		local_variables[key] = story.variables_state.get(key)

	story.observe_variables(variable_keys, self, "_on_variable_changed")

	update_level()

	# Connect necessary signals?
	var wheelie : classCharacter = $Sorted/Characters/Wheelie
	var _error := wheelie.connect("nav_path_requested", self, "_on_nav_path_requested", [wheelie])

	var dog : classCharacter = $Sorted/Characters/Dog
	_error = dog.connect("nav_path_requested", self, "_on_nav_path_requested", [dog])

	var solid_snejk := $Sorted/Characters/SolidSnejk

	#emit_signal("dialogue_requested", solid_snejk)

func _on_variable_changed(property : String, value : int):
	local_variables[property] = value

	update_level()

func update_level():
	for key in local_variables:
		match key:
			"wind_turbine_powered":
				if local_variables[key]:
					$Vortex.visible = false
				else:
					$Vortex.visible = true
			"number_of_fences_fixed":
				var index := 0
				for child in $Sorted/Fences.get_children():
					if index < local_variables[key]:
						child.set_visible(true)
					else:
						child.set_visible(false)
					index += 1
			"player_wearing_color":
				if local_variables[key]:
					$CopperBlockade/CollisionShape2D.disabled = true
				else:
					$CopperBlockade/CollisionShape2D.disabled = false
