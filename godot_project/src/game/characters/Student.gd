extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var animations := {}

	match State.level_state:
		State.LEVEL.MAIN:
			var student_gone_protesting : int = local_variables.get("student_gone_protesting", 0)
			if student_gone_protesting:
				animations = animations_dict.get("protesting", {})
			else:
				animations = animations_dict.get("default", {})
		State.LEVEL.OUTRO:
			animations = animations_dict.get("default", {})

	_animated_sprite.play(animations.get("animation_name", "default"))
	_animated_sprite.offset = animations.get("offset", Vector2.ZERO)

	if animations.has("waypoint_id"):
		var waypoint_id : String = animations.waypoint_id
		position = Flow.get_waypoint_position(waypoint_id)

var animations_dict := {
	"default":
		{
			"animation_name": "default",
			"offset": Vector2(1, -20)
		},
	"protesting":
		{
			"animation_name": "protesting",
			"offset": Vector2(6, -34),
			"waypoint_id": "protesting_student"
		}
}
