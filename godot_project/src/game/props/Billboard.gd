extends StaticBody2D

func _ready():
	add_to_group("billboards")

func update_poster():
	$Backdrop/Poster.texture = Flow.poster_texture
