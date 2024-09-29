class_name PauseMenu
extends Control



func _on_options_button_pressed():
	pass # Replace with function body.

func _on_main_menu_button_pressed():
	MessageBus.game_scene_changed.emit(Globals.main_menu_scene)
	MessageBus.pause_menu_toggled.emit()
	
func _on_quit_button_pressed():
	MessageBus.quit_game.emit()
