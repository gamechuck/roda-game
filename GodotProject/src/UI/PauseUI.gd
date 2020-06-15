extends Control

onready var _tab_container := $TabContainer

onready var _main_tab := $TabContainer/MainTab
onready var _settings_tab := $TabContainer/SettingsTab

func _ready():
	Flow.pause_UI = self

	var _error : int = _main_tab.connect("change_tab_requested", self, "_on_tab_change_requested")
	_error = _settings_tab.connect("change_tab_requested", self, "_on_tab_change_requested")

func _on_tab_change_requested(index : int):
	_tab_container.current_tab = index
