extends RigidBody2D

func _ready():
	
	# Add some randomness to the direction.
	var direction = rand_range(-PI / 4, PI / 4)
	rotation = direction
	# Set the velocity (speed & direction).
	#linear_velocity = Vector2(rand_range(20, 100), 0)
	#linear_velocity = linear_velocity.rotated(direction)
