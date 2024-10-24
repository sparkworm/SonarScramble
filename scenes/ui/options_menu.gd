class_name OptionsMenu
extends Control

var setting_slider_scene: PackedScene = preload("res://scenes/ui/setting_slider.tscn")

@onready var option_container: VBoxContainer = %OptionContainer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		MessageBus.menu_pressed.emit()

func _ready() -> void:
	create_volume_sliders()

func create_volume_sliders() -> void:
	for sound in Settings.sound_settings.keys():
		var setting_slider: SettingSlider = setting_slider_scene.instantiate()
		setting_slider.text = sound
		setting_slider.min_val = -50
		setting_slider.max_val = 50
		setting_slider.value_changed.connect(\
				Callable(self, "update_sound_settings").bind(sound))

func update_sound_settings(new_value: float, sound: String) -> void:
	Settings.sound_settings[sound] = new_value
	Settings.sound_settings_updated.emit()
