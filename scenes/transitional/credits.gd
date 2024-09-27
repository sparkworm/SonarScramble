extends GameScene

var main_menu = preload("res://scenes/transitional/main_menu.tscn")

func quit_to_menu() -> void:
	MessageBus.game_scene_changed.emit(main_menu)
