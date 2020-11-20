class_name classPickup
extends Area2D

onready var _collision_shape_2D := $CollisionShape2D

export(String) var id : String
var state : classPickupState

func _ready():
	add_to_group("pickups")

	# Initiate the pickup's state!
	state = State.get_pickup_by_id(id)
	if state:
		state.object = self
		if visible != state.visible:
			set_visible(state.visible)
	else:
		push_error("Character with id '{0}' does not have a valid registered state in the context!".format([id]))

	set_visible()

func set_visible(value : bool = visible):
	visible = value
	if visible:
		if ConfigData.verbose_mode : print("Enabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = false
		set_process_input(true)
	else:
		if ConfigData.verbose_mode : print("Disabling '{0}' collision shapes...".format([name]))
		_collision_shape_2D.disabled = true
		set_process_input(false)

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var extents : Vector2 = _collision_shape_2D.shape.extents
		var rect : Rect2 = Rect2(position - extents, 2*extents)
		if rect.has_point(get_global_mouse_position()):
			Flow.active_pickup = self
		# This is a bit filthy, but it does the job!
		# Otherwise new mouse clicks might still contain the
		# now obsolete active_pickup!
		elif Flow.active_pickup == self:
			Flow.active_pickup = null
