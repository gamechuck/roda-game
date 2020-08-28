extends class_character
class_name class_player

enum MOVING {IDLE, WALK}
enum DIRECTION {LEFT, RIGHT, UP, DOWN}
enum TRANSPORT_MODE {FOOT, BIKE}
enum CLOTHING {PLAIN, COLORFUL}

var _moving : int = MOVING.IDLE
var _direction : int = DIRECTION.DOWN

var respawn_position := Vector2.ZERO
var nav_path : PoolVector2Array = []

var _overlapping_character : class_character = null
var _overlapping_pickup : class_pickup = null
var _overlapping_with_gummy := false

var _is_inside_cutscene := false

var _target_entity : CollisionObject2D = null

onready var _interact_area := $InteractArea
onready var _tween := $Tween

signal nav_path_requested()

signal dialogue_started()
signal cutscene_started()

func _ready():
	Flow.player = self
	respawn_position = position

	register_state_property("on_bike", TRANSPORT_MODE.FOOT)
	register_state_property("wearing_color", CLOTHING.PLAIN)

	var _error := _interact_area.connect("area_entered", self, "_on_interact_area_entered")
	_error = _interact_area.connect("area_exited", self, "_on_interact_area_exited")

	_error = _interact_area.connect("area_entered", self, "_on_area_entered")

	_error = connect("dialogue_started", Director, "_on_dialogue_started")
	_error = connect("cutscene_started", Director, "play_cutscene")

	_error = Director.connect("dialogue_ended", self, "_on_dialogue_ended")
	_error = Director.connect("cutscene_ended", self, "_on_cutscene_ended")

	update_animation()

func _on_dialogue_ended():
	if not _is_inside_cutscene:
		# Enable the player again!
		set_physics_process(true)
		set_process_unhandled_input(true)

func _on_cutscene_ended():
	_is_inside_cutscene = false
	_on_dialogue_ended()

func start_dialogue(entity : CollisionObject2D, item_id : String = ""):
	set_physics_process(false)
	set_process_unhandled_input(false)

	emit_signal("dialogue_started", entity, item_id)

func start_cutscene(cutscene_id : String):
	if not _is_inside_cutscene:
		set_physics_process(false)
		set_process_unhandled_input(false)

		emit_signal("cutscene_started", [cutscene_id])

		_is_inside_cutscene = true

func _physics_process(_delta):
	if not Flow.is_in_editor_mode:
		var move_direction := Vector2.ZERO
		var move_speed := get_move_speed()

		if Input.is_action_pressed("move_down"):
			move_direction.y += 1
		if Input.is_action_pressed("move_up"):
			move_direction.y -= 1
		if Input.is_action_pressed("move_left"):
			move_direction.x -= 1
		if Input.is_action_pressed("move_right"):
			move_direction.x += 1
	
		if not move_direction == Vector2.ZERO:
			nav_path = PoolVector2Array()
			_target_entity = null

		if nav_path.size() > 0:
			var distance := position.distance_to(nav_path[0])
			if distance > ConfigData.player_move_speed:
				var new_position := position.linear_interpolate(nav_path[0], move_speed/distance)
				move_direction = new_position - position
			else:
				nav_path.remove(0)

		update_state(move_direction)
		var normalized_direction := move_direction.normalized()
		var _linear_velocity := move_and_slide(normalized_direction*move_speed/_delta)

func _unhandled_input(event):
## Inputs that are NOT handled by any of the UI elements!
	if event.is_action_pressed("interact"):
		if _overlapping_character:
			start_dialogue(_overlapping_character)
		elif _overlapping_pickup:
			start_dialogue(_overlapping_pickup)
			Flow.inventory.add_item(_overlapping_pickup)

	if event.is_action_pressed("toggle_inventory"):
		Flow.toggle_inventory()

	if event.is_action_pressed("left_mouse_button"):
		_target_entity = null
		if Flow.active_character != null:
			process_interaction(Flow.active_character)
			Flow.active_character = null
		elif Flow.active_pickup != null:
			process_interaction(Flow.active_pickup)
			Flow.active_pickup = null
		else:
			emit_signal("nav_path_requested")

func process_interaction(active_entity : CollisionObject2D):
	var entity_position = active_entity.position
	var distance : float = position.distance_to(entity_position)
	print("Distance to entity ('{0}') is {1}".format([active_entity.name, distance]))
	if distance > ConfigData.minimum_interaction_distance:
		_target_entity = active_entity
		emit_signal("nav_path_requested")
	elif Flow.active_item != null:
		var item : class_item_state = Flow.active_item
		var item_id = item.id
		start_dialogue(active_entity, item_id)
		Flow.inventory.reset_slots()
	else:
		start_dialogue(active_entity)
		if active_entity is class_pickup:
			Flow.inventory.add_item(active_entity)

func _on_interact_area_entered(area):
	if not area:
		return

	if area.get_parent() is class_character:
		print("Player entered a character's interact area!")
		_overlapping_character = area.get_parent()
		if _overlapping_character == _target_entity or \
		_overlapping_character is class_canster and _overlapping_character.state == class_canster.STATE.ANGRY:
			process_interaction(_overlapping_character)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is class_pickup:
		#respawn_position = position
		print("Player entered the item!")
		_overlapping_pickup = area
		if _overlapping_pickup == _target_entity:
			process_interaction(_overlapping_pickup)
			_target_entity = null
			nav_path = PoolVector2Array()
	elif area is class_gummy:
		_overlapping_with_gummy = true
		print("Player entered gummy!")
	elif area is class_safe_zone:
		respawn_position = area.position
		print("Player entered a safe zone!")

func _on_interact_area_exited(area):
	if not area:
		return

	if area.get_parent() is class_character:
		print("Player exited a character's interact area!")
		if _overlapping_character == area.get_parent():
			_overlapping_character = null
	if area is class_pickup:
		#respawn_position = position
		print("Player exited the item!")
		if _overlapping_pickup == area:
			_overlapping_pickup = null
	if area is class_gummy:
		_overlapping_with_gummy = false
		print("Player exited gummy!")

func _on_area_entered(area):
# Stuff that should really be precise should be added here!
	if area is class_car:
		start_cutscene("respawn")
		nav_path = PoolVector2Array()
		print("Player got hit by a car!")
	elif area is class_skater:
		start_cutscene("respawn")
		nav_path = PoolVector2Array()
		print("Player got hit by a skater!")

func get_move_speed() -> float:
	var move_speed := ConfigData.player_move_speed
	if get_state_property("on_bike") == TRANSPORT_MODE.BIKE:
		move_speed *= ConfigData.bike_modifier
	elif _overlapping_with_gummy:
		move_speed *= ConfigData.gummy_modifier
	return move_speed

func update_state(move_direction : Vector2):
	var normalized_direction := move_direction.normalized()
	var abs_direction := normalized_direction.abs()
	var old_moving : int = _moving
	var old_direction : int = _direction

	if abs_direction.x >= abs_direction.y:
		if normalized_direction.x > 0:
			_direction = DIRECTION.RIGHT
			_moving = MOVING.WALK
		elif normalized_direction.x < 0:
			_direction = DIRECTION.LEFT
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	elif abs_direction.y > abs_direction.x:
		if normalized_direction.y > 0:
			_direction = DIRECTION.DOWN
			_moving = MOVING.WALK
		elif normalized_direction.y < 0:
			_direction = DIRECTION.UP
			_moving = MOVING.WALK
		else:
			_moving = MOVING.IDLE
	else:
		_moving = MOVING.IDLE

	if old_moving != _moving or old_direction != _direction:
		update_animation()

func update_animation():
	var direction : int = _direction
	var moving : int = _moving
	var clothing : int = get_state_property("wearing_color")
	var transport_mode : int = get_state_property("on_bike")

	var state_settings : Dictionary = state_machine.get(direction, {})
	state_settings = state_settings.get(transport_mode, {})
	state_settings = state_settings.get(moving, {})
	state_settings = state_settings.get(clothing, {})

	_animated_sprite.play(state_settings.get("animation_name", "default"))
	_animated_sprite.flip_h = state_settings.get("flip_h", false)
	#_animated_sprite.flip_v = clothing_settings.get("flip_v", false)

var state_machine := {
	DIRECTION.LEFT:{
		TRANSPORT_MODE.FOOT: {
			MOVING.IDLE: {
				CLOTHING.PLAIN: {
					"animation_name": "idle_right",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "idle_right_color",
					"flip_h": true
				},
			},
			MOVING.WALK: {
				CLOTHING.PLAIN: {
					"animation_name": "walk_right",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "walk_right_color",
					"flip_h": true
				}
			}
		},
		TRANSPORT_MODE.BIKE: {
			MOVING.IDLE:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_right_idle",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_right_idle_color",
					"flip_h": true
				}
			},
			MOVING.WALK:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_right",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_right_color",
					"flip_h": true
				}
			}
		}
	},
	DIRECTION.RIGHT:{
		TRANSPORT_MODE.FOOT: {
			MOVING.IDLE: {
				CLOTHING.PLAIN: {
					"animation_name": "idle_right",
				},
				CLOTHING.COLORFUL: {
					"animation_name": "idle_right_color",
				},
			},
			MOVING.WALK: {
				CLOTHING.PLAIN: {
					"animation_name": "walk_right",
				},
				CLOTHING.COLORFUL: {
					"animation_name": "walk_right_color",
				}
			}
		},
		TRANSPORT_MODE.BIKE: {
			MOVING.IDLE:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_right_idle",
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_right_idle_color",
				}
			},
			MOVING.WALK:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_right",
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_right_color",
				}
			}
		}
	},
	DIRECTION.UP:{
		TRANSPORT_MODE.FOOT: {
			MOVING.IDLE: {
				CLOTHING.PLAIN: {
					"animation_name": "idle_up",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "idle_up_color",
					"flip_h": true
				},
			},
			MOVING.WALK: {
				CLOTHING.PLAIN: {
					"animation_name": "walk_up",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "walk_up_color",
					"flip_h": true
				}
			}
		},
		TRANSPORT_MODE.BIKE: {
			MOVING.IDLE:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_up_idle",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_up_idle_color",
					"flip_h": true
				}
			},
			MOVING.WALK:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_up",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_up_color",
					"flip_h": true
				}
			}
		}
	},
	DIRECTION.DOWN:{
		TRANSPORT_MODE.FOOT: {
			MOVING.IDLE: {
				CLOTHING.PLAIN: {
					"animation_name": "idle_down",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "idle_down_color",
					"flip_h": true
				},
			},
			MOVING.WALK: {
				CLOTHING.PLAIN: {
					"animation_name": "walk_down",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "walk_down_color",
					"flip_h": true
				}
			}
		},
		TRANSPORT_MODE.BIKE: {
			MOVING.IDLE:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_down_idle",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_down_idle_color",
					"flip_h": true
				}
			},
			MOVING.WALK:{
				CLOTHING.PLAIN: {
					"animation_name": "cycle_down",
					"flip_h": true
				},
				CLOTHING.COLORFUL: {
					"animation_name": "cycle_down_color",
					"flip_h": true
				}
			}
		}
	}
}

func respawn():
	set_process_unhandled_input(false)

	var anim_sprite := $AnimatedSprite

	# Position is taken here to acount for previous cutscenes!!!
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position, anim_sprite.position + Vector2(0, -200), 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.interpolate_property(anim_sprite, "rotation_degrees", anim_sprite.rotation_degrees, 0, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(self,"position", position, respawn_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", anim_sprite.position + Vector2(0, -200), Vector2(0, -200), 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(anim_sprite, "position", Vector2(0, -200), Vector2.ZERO, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	set_process_unhandled_input(true)

func teleport(target_position : Vector2):
	set_process_unhandled_input(false)

	Flow.transitions_UI.fade_to_opaque()
	yield(Flow.transitions_UI, "transition_completed")

	Flow.dialogue_UI.update_dialogue()
	_tween.interpolate_property(self, "position", position, target_position, 0.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	Flow.transitions_UI.fade_to_transparent()
	yield(Flow.transitions_UI, "transition_completed")

	set_process_unhandled_input(true)

func chew_on_player(canster : class_canster):

	set_process_unhandled_input(false)

	var target_position = canster.position - position
	target_position.y -= 40
	_tween.interpolate_property($AnimatedSprite, "position", Vector2.ZERO, target_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.interpolate_property($AnimatedSprite, "rotation_degrees", $AnimatedSprite.rotation_degrees, 180, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	bias = target_position.y
	_tween.interpolate_method(self, "_sinusoidal_movement", 0, 4, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_all_completed")

	Flow.dialogue_UI.update_dialogue()

	set_process_unhandled_input(true)

func drop_player(taxi : class_character):
	set_process_unhandled_input(false)

	$AnimatedSprite.visible = false
	_tween.interpolate_property(taxi.get_node("AnimatedSprite"), "position", Vector2.ZERO, Vector2(0, -100), 2.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	$AnimatedSprite.visible = true
	_tween.interpolate_property($AnimatedSprite, "rotation_degrees", 0, 90, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(taxi.get_node("AnimatedSprite"), "position", Vector2(0, -100), Vector2(-400, -100), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	taxi.get_node("AnimatedSprite").position = Vector2(600, -100)
	_tween.interpolate_property(taxi.get_node("AnimatedSprite"),"position",Vector2(600, -100),Vector2(0, -100), 2.0,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	_tween.interpolate_property(taxi.get_node("AnimatedSprite"),"position",Vector2(0, -100),Vector2.ZERO, 2.0,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	
	_tween.interpolate_property($AnimatedSprite, "rotation_degrees", 90, 0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")

	Flow.dialogue_UI.update_dialogue()
	set_process_unhandled_input(true)

var bias : float = 0.0

func _sinusoidal_movement(time : float):
	var amplitude := 10
	$AnimatedSprite.position.y = amplitude*sin(2*PI*1*time) + bias
