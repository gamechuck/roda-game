# Overlay that is always visible in-game.
extends Control

onready var _version_label := $MarginContainer/VBoxContainer/VersionLabel

func _ready():
	var _error : int = ConfigData.connect("version_visibility_changed", self, "update_version_label")

	update_version_label()

func update_version_label():
	if ConfigData.show_version:
		_version_label.text = "v{0}.{1}".format([ConfigData.major_version, ConfigData.minor_version])
		_version_label.visible = true
	else:
		_version_label.visible = false
