extends KinematicBody2D
class_name class_character

onready var _collision_shape_2D := $CollisionShape2D
onready var _interact_collision_shape_2D := $InteractArea/CollisionShape2D
onready var _audio_stream_player := $AudioStreamPlayer
onready var _animated_sprite := $AnimatedSprite

export(String) var id : String

var state : class_character_state setget set_state, get_state
func set_state(value : class_character_state) -> void:
	if value:
		_state = weakref(value)
		value.object = self
		if visible != value.visible:
			set_visible(value.visible)
func get_state() -> class_character_state:
	return _state.get_ref()
var _state = WeakRef.new()

func register_state_property(property : String, value : int) -> void:
	if self.state:
		if self.state.properties.has(property):
			# Don't register it if it already exists!
			return
		else:
			self.state.properties[property] = value

func get_state_property(property : String) -> int:
	if self.state and self.state.properties.has(property):
		return self.state.properties[property]
	else:
		push_error("Property with name '{0}' was not defined in the character state!".format([property]))
	return 0

func set_state_property(property : String, value : int):
	if self.state:
		if property in self.state.properties:
			self.state.properties[property] = value
		else:
			push_error("Property with name '{0}' was not defined in the character state!".format([property]))

func _ready():
	# Initiate the character's state!
	self.state = State.get_character_by_id(id)

	set_visible()

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
