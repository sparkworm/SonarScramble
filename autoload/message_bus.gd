extends Node

signal game_scene_changed(new_scene: PackedScene, text: String)
signal player_scanned()
signal quit_game()

# to be DEPRECATED
signal menu_pressed()

signal top_menu_closed()
signal menu_opened(menu: PackedScene)
