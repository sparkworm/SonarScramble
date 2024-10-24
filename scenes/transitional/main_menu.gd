class_name MainMenu
extends GameScene

@export var first_level: PackedScene
@export var options_menu: PackedScene

func _on_play_button_pressed() -> void:
	MessageBus.game_scene_changed.emit(first_level)

func _on_options_button_pressed() -> void:
	MessageBus.menu_opened.emit(options_menu)

func _on_quit_button_pressed() -> void:
	MessageBus.quit_game.emit()
