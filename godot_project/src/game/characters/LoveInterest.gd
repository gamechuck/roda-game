extends classCharacter

func _ready():
	call_deferred("update_animation")

func update_animation():
	var animations := {}

	var player_wearing_color : int = local_variables.get("player_wearing_color", 0)
	if player_wearing_color:
		animations = plain_animations
	else:
		animations = colorful_animations

	match State.level_state:
		State.LEVEL.MAIN:
			var love_interest_gone_protesting : int = local_variables.get("love_interest_gone_protesting", 0)
			if love_interest_gone_protesting:
				animations = animations.get("protesting", {})
			else:
				animations = animations.get("default", {})
		State.LEVEL.OUTRO:
			animations = animations.get("default", {})

	_animated_sprite.play(animations.get("animation_name", "default"))
	_animated_sprite.offset = animations.get("offset", Vector2.ZERO)

	if animations.has("waypoint_id"):
		var waypoint_id : String = animations.waypoint_id
		position = Flow.get_waypoint_position(waypoint_id)

var plain_animations := {
	"default":
		{
			"animation_name": "default",
			"offset": Vector2(-2, -22)
		},
	"protesting":
		{
			"animation_name": "protesting",
			"offset": Vector2(11, -42),
			"waypoint_id": "protesting_love_interest"
		}
}

var colorful_animations := {
	"default":
		{
			"animation_name": "wearing_color",
			"offset": Vector2(-2, -22)
		},
	"protesting":
		{
			"animation_name": "protesting",
			"offset": Vector2(11, -42),
			"waypoint_id": "protesting_love_interest"
		}
}
