extends KinematicBody2D
class_name class_character

onready var _collision_shape_2D := $CollisionShape2D
onready var _interact_collision_shape_2D := $InteractArea/CollisionShape2D
onready var _audio_stream_player := $AudioStreamPlayer
onready var _animated_sprite := $AnimatedSprite

export var id : String

func _ready():
	add_to_group("characters")

	set_visible()

func _exit_tree():
	if is_inside_tree() and get_tree().has_group("characters"):
		remove_from_group("characters")

func set_visible(value : bool = visible):
	visible = value
	if visible:
		if ConfigData.verbose_mode : print("Enabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = false
		_interact_collision_shape_2D.disabled = false
	else:
		if ConfigData.verbose_mode : print("Disabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = true
		_interact_collision_shape_2D.disabled = true

func play_sound_byte():
	_audio_stream_player.play()

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var extents : Vector2 = _interact_collision_shape_2D.shape.extents
		var rect : Rect2 = Rect2(position - extents, 2*extents)
		if rect.has_point(get_global_mouse_position()):
			Flow.active_character = self
		# This is a bit filthy, but it does the job!
		# Otherwise new mouse clicks might still contain the 
		# now obsolete active_character!
		elif Flow.active_character == self:
			Flow.active_character = null
