extends Node2D

onready var _navigation_2D := $Navigation2D
onready var _player := $YSort/Player
onready var _props := $YSort/Props
onready var _fences := $YSort/Fences

func _ready():
	Flow.game_canvas = self
	var _error := _player.connect("nav_path_requested", self, "_on_nav_path_requested")

	return
	var navigation_polygon_instance := $Navigation2D/NavigationPolygonInstance
	var navigation_polygon = navigation_polygon_instance.navpoly

	for prop in _props.get_children():
		#var nav_polygon = NavigationPolygon.new()
		var outline : PoolVector2Array = prop.get_node("CollisionPolygon2D").polygon
		print(outline)
		for i in range(0, outline.size()):
			print(outline[i].length())
			outline[i] = (outline[i].length())*outline[i].normalized()
			outline[i] += prop.position
#		var rect = Rect2(prop.position - shape.extents, 2*shape.extents)
#		rect = rect.grow(10)
#		print(polygon_from_box(rect))
		#var outline = PoolVector2Array([Vector2(0, 0), Vector2(0, 50), Vector2(50, 50), Vector2(50, 0)])
		outline.invert()
		navigation_polygon.add_outline(outline)
		navigation_polygon.make_polygons_from_outlines()
		#_navigation_2D.navpoly_add(nav_polygon, Transform2D.IDENTITY)

	navigation_polygon_instance.enabled = false
	navigation_polygon_instance.enabled = true

func _on_nav_path_requested():
	var mouse_position := get_local_mouse_position()
	#print(mouse_position)
	print("Player is navigating to '{0}'".format([mouse_position]))
	var nav_path = _navigation_2D.get_simple_path(_player.position, mouse_position)
	# Remove the first point since it is the initial position!!!
	nav_path.remove(0)
	_player.nav_path = nav_path

func increment_visible_fences():
	for fence in _fences.get_children():
		if fence.visible == false:
			fence.collision_layer = 1
			fence.visible = true
			return
