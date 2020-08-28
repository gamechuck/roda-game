# Overlay that is always visible in-game.
tool
extends Control

onready var _version_label := $MarginContainer/VBoxContainer/VersionLabel

export(float, 0.0, 1.0) var smog_amount := 0.0 setget set_smog_amount 
func set_smog_amount(value : float):
	smog_amount = value
	$SmogOverlay.material.set_shader_param("amount", value)

func _ready():
	if not Engine.editor_hint:
		var _error : int = ConfigData.connect("version_visibility_changed", self, "update_version_label")

		update_version_label()

func update_version_label():
	if ConfigData.show_version:
		_version_label.text = "v{0}.{1}".format([ConfigData.major_version, ConfigData.minor_version])
		_version_label.visible = true
	else:
		_version_label.visible = false
