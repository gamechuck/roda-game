class_name classCharacter
extends KinematicBody2D

onready var _collision_shape_2D := $CollisionShape2D
onready var _interact_collision_shape_2D := $InteractArea/CollisionShape2D
onready var _audio_stream_player := $AudioStreamPlayer
onready var _animated_sprite := $AnimatedSprite

export(String) var id : String
var state : classCharacterState

func get_state_property(property : String) -> int:
	if state:
		if state.properties.has(property):
			return state.properties[property]
		else:
			push_error("Property with name '{0}' was not defined in the character state!".format([property]))
	return 0

func set_state_property(property : String, value : int):
	if state:
		if state.properties.has(property):
			state.properties[property] = value
		else:
			push_error("Property with name '{0}' was not defined in the character state!".format([property]))

func _ready():
	add_to_group("characters")

	# Initiate the character's state!
	state = State.get_character_by_id(id)
	if state:
		state.object = self
		set_visible(state.visible)
	else:
		push_error("Character with id '{0}' does not have a valid registered state in the context!".format([id]))

func set_visible(value : bool = visible):
	visible = value
	if visible:
		if ConfigData.verbose_mode : print("Enabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = false
		_interact_collision_shape_2D.disabled = false
		set_process_input(true)
		set_physics_process(true)
	else:
		if ConfigData.verbose_mode : print("Disabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = true
		_interact_collision_shape_2D.disabled = true
		set_process_input(false)
		set_physics_process(false)

func play_sound_byte():
	_audio_stream_player.play()

func update_animation():
	pass

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var extents : Vector2 = _interact_collision_shape_2D.shape.extents
		var rect : Rect2 = Rect2(position - extents, 2*extents)
		if name == "Player":
			if rect.has_point(get_global_mouse_position()):
				Flow.player_is_active = true
			else:
				Flow.player_is_active = false
		else:
			if rect.has_point(get_global_mouse_position()):
				Flow.active_character = self
			# This is a bit filthy, but it does the job!
			# Otherwise new mouse clicks might still contain the
			# now obsolete active_character!
			elif Flow.active_character == self:
				Flow.active_character = null
