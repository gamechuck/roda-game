extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var animations := {}

	match State.level_state:
		State.LEVEL.MAIN:
			var old_man_gone_protesting : int = local_variables.get("old_man_gone_protesting", 0)
			if old_man_gone_protesting:
				animations = animations_dict.get("protesting", {})
			else:
				animations = animations_dict.get("default", {})
		State.LEVEL.OUTRO:
			animations = animations_dict.get("protesting", {})

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
			"offset": Vector2(-1, -36),
			"visible": true
		}
}

