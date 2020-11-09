extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var animations := {}

	match State.level_state:
		State.LEVEL.MAIN:
			var operation_better_park_started : int = local_variables.get("operation_better_park_started", 0)
			if operation_better_park_started:
				animations = animations_dict.get("protesting", {})
			else:
				animations = animations_dict.get("default", {})
		State.LEVEL.OUTRO:
			animations = animations_dict.get("default", {})

	_animated_sprite.play(animations.get("animation_name", "default"))
	_animated_sprite.offset = animations.get("offset", Vector2.ZERO)

var animations_dict := {
	"default":
		{
			"animation_name": "default",
			"offset": Vector2(6, -21)
		},
	"protesting":
		{
			"animation_name": "protesting",
			"offset": Vector2(1, -37)
		}
}

