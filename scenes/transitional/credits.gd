extends GameScene

#var main_menu = preload("res://scenes/transitional/main_menu.tscn")

func quit_to_menu() -> void:
	MessageBus.game_scene_changed.emit(Globals.main_menu_scene)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		quit_to_menu()
