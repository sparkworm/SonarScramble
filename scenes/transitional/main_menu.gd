class_name MainMenu
extends GameScene

@export var first_level: PackedScene

func _on_play_button_pressed() -> void:
	MessageBus.game_scene_changed.emit(first_level)

func _on_options_button_pressed() -> void:
	pass # Replace with function body.
