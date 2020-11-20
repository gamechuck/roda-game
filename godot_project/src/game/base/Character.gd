class_name classCharacter
extends KinematicBody2D

onready var _collision_shape_2D := $CollisionShape2D
onready var _interact_collision_shape_2D := $InteractArea/CollisionShape2D
onready var _audio_stream_player := $AudioStreamPlayer
onready var _animated_sprite := $AnimatedSprite

export(String) var id : String
var state : classCharacterState

# Local copy of the story variables.
var local_variables := {}

var mouse_inside := false

func _ready():
	add_to_group("characters")

	var _error := $InteractArea.connect("mouse_entered", self, "_on_mouse_entered")
	_error = $InteractArea.connect("mouse_exited", self, "_on_mouse_exited")

	# Initiate the character's state!
	state = State.get_character_by_id(id)
	if state:
		state.object = self
		var story : Reference = Director.story
		var story_bindings : Array = state.story_bindings

		for key in story_bindings:
			local_variables[key] = story.variables_state.get(key)

		story.observe_variables(story_bindings, self, "_on_variable_changed")
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
	$AudioStreamPlayer.play()

func _on_variable_changed(property : String, value : int):
	local_variables[property] = value
	print("updating local variable '{0}' to value '{1}'".format([property, value]))

	update_animation()

func set_story_variable(property : String, value : int):
	var story : Reference = Director.story
	story.variables_state.set(property, value)

func update_animation():
	pass

func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _input(event):
	if event.is_action_released("left_mouse_button") and mouse_inside:
		Flow.active_character = self
	elif Flow.active_character == self:
		Flow.active_character = null
