extends StaticBody2D
class_name class_character

onready var _interact_collision_shape_2D := $InteractArea/CollisionShape2D
onready var _audio_stream_player := $AudioStreamPlayer
onready var _animated_sprite := $AnimatedSprite

export var id : String

func play_sound_byte():
	_audio_stream_player.play()

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var extents : Vector2 = _interact_collision_shape_2D.shape.extents
		var rect : Rect2 = Rect2(position - extents, 2*extents)
		if rect.has_point(get_global_mouse_position()):
			Flow.active_character = self
		# This is a bit filthy, but it does the job!
		# Otherwise new mouseclicks might still contain the 
		# now obsolete active_character!
		elif Flow.active_character == self:
			Flow.active_character = null
