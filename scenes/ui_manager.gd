class_name UIManager
extends Node

## The node holding the various menus, allowing them to be displayed.
## [br]
## New menus are added here.
@export var ui_parent: CanvasLayer

## An array holding the current "stack" of menus, which should always start 
## from the pause menu.
var menu_array: Array[Control]

## Reference to the pause menu, which is a key part of this menu system.
@onready var pause_menu: PauseMenu = %PauseMenu

func _ready() -> void:
	MessageBus.menu_opened.connect(Callable(self, "open_menu"))
	MessageBus.top_menu_closed.connect(Callable(self, "close_outer_menu"))
	
	MessageBus.game_scene_changed.connect(Callable(self, "clear_menus"))
	#MessageBus.menu_pressed.connect(Callable(self, "toggle_menu"))

## Called via a signal from some existing menu.  
## [br]
## THIS DOES NOT OPEN PAUSE MENU
func open_menu(menu: PackedScene) -> void:
	print("opening window")
	var new_menu = menu.instantiate()
	menu_array.append(new_menu)
	ui_parent.add_child(new_menu)
	Globals.menu_depth += 1

func close_outer_menu() -> void:
	print("closing outer window")
	var removed_menu = menu_array[menu_array.size()-1]
	ui_parent.remove_child(removed_menu)
	menu_array.remove_at(menu_array.size()-1)
	Globals.menu_depth -= 1

func clear_menus(_new_scene:PackedScene, _text: String="") -> void:
	while Globals.menu_depth > 0:
		close_outer_menu()
