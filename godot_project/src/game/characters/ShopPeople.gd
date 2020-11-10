extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var animations := {}

	var gone_protesting := 0
	for key in local_variables.keys():
		if key.ends_with("gone_protesting"):
			gone_protesting = local_variables[key]

	if gone_protesting:
		animations = animations_dict.get("protesting", {})
	else:
		animations = animations_dict.get("default", {})

	_animated_sprite.play(animations.get("animation_name", "default"))
	_animated_sprite.offset = animations.get("offset", Vector2.ZERO)

	_animated_sprite.flip_h = animations.get("flip_h", false)
	_animated_sprite.flip_v = animations.get("flip_v", false)

	set_visible(animations.get("visible", true))

var animations_dict := {
	"default":
		{
			"visible": false
		},
	"protesting":
		{
			"animation_name": "default",
			"offset": Vector2(11, -42),
			"visible": true
		}
}
