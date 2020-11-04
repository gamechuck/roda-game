extends classLevel

func _ready():
	emit_signal("cutscene_requested", "intro")
