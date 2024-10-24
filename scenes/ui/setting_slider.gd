## Class for sliders with a title above [br]
## TODO: Add functionality for a reset button
class_name SettingSlider
extends VBoxContainer

signal value_changed(new_value)

@export var text: String = ""
@export var min_val: float = 0.0
@export var max_val: float = 100.0

func _ready() -> void:
	$Label.text = text
	$HBoxContainer/HSlider.min_value = min_val
	$HBoxContainer/HSlider.max_value = max_val
	
	$HBoxContainer/HSlider.value_changed.connect(Callable(self, "change_value"))

func change_value() -> void:
	var new_value = $HBoxContainer/HSlider.value
	value_changed.emit(new_value)
