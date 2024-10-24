class_name PauseMenu
extends Control

@export var options_menu: PackedScene

func _on_options_button_pressed():
	MessageBus.menu_opened.emit(options_menu)

func _on_main_menu_button_pressed():
	MessageBus.game_scene_changed.emit(Globals.main_menu_scene, "Coward...")
	MessageBus.menu_pressed.emit()
	
func _on_quit_button_pressed():
	MessageBus.quit_game.emit()
