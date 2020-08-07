extends class_smog_particle

var _speed := 1
var _radius_compounded := 0.0
var _radius_increment := 0.5

func _ready():
	pass # Replace with function body.

func _physics_process(delta : float):
	rotation += _speed * delta;

	position = Vector2(sin(rotation), cos(rotation)) * _radius_compounded;

	_radius_compounded += _radius_increment
