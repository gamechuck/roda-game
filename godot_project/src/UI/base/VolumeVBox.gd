extends VBoxContainer

func _on_slider_value_changed(value : float):
	$HBoxContainer/VolumeLabel.text = "%3d %%" % value
	ConfigData.master_volume = value

func _ready():
	var _error : int = $HBoxContainer/VolumeSlider.connect("value_changed", self, "_on_slider_value_changed")

func update_setting() -> void:
	$HBoxContainer/VolumeSlider.value = ConfigData.master_volume
