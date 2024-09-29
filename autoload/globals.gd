extends Node

var is_paused: bool = false

var main_menu_scene: PackedScene = preload("res://scenes/transitional/main_menu.tscn")

func toggle_pause() -> bool:
	is_paused = not is_paused
	return is_paused
