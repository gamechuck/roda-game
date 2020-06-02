extends Node2D

onready var _navigation_2D := $Navigation2D
onready var _player := $YSort/Player
onready var _props := $YSort/Props

func _ready():
	pass
	var navigation_polygon_instance := $Navigation2D/NavigationPolygonInstance
#	var navigation_polygon = navigation_polygon_instance.navpoly

	for prop in _props.get_children():
		var nav_polygon = NavigationPolygon.new()
		var outline : PoolVector2Array = prop.get_node("CollisionPolygon2D").polygon
		for i in range(0, outline.size()):
			outline[i] += prop.position
#		var rect = Rect2(prop.position - shape.extents, 2*shape.extents)
#		rect = rect.grow(10)
#		print(polygon_from_box(rect))
		#var outline = PoolVector2Array([Vector2(0, 0), Vector2(0, 50), Vector2(50, 50), Vector2(50, 0)])
		#outline.invert()
		nav_polygon.add_outline(outline)
		nav_polygon.make_polygons_from_outlines()
		_navigation_2D.navpoly_add(nav_polygon, Transform2D.IDENTITY)

	navigation_polygon_instance.enabled = false
	navigation_polygon_instance.enabled = true

func _input(event):
	if not Flow.is_in_editor_mode:
		if event.is_action_pressed("move_to_position"):
			var mouse_position := get_local_mouse_position()
			print("Player is navigating to '{0}'".format([mouse_position]))
			_player.nav_path = _navigation_2D.get_simple_path(_player.position, mouse_position)
