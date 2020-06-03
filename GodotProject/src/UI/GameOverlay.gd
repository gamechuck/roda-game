extends Control

onready var _version_label := $MarginContainer/VBoxContainer/VersionLabel

func _ready():
	_version_label.text = "v{0}.{1}".format([Flow.major_version, Flow.minor_version])
