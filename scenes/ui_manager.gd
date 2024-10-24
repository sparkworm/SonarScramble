class_name UIManager
extends Node

## the state of the ui, used to determine what should happen when menu is 
## pressed
enum UILevels {
	## menu button should bring up pause menu
	NO_UI, 
	## menu button should resume game
	PAUSE_MENU, 
	## menu button should close the outermost menu
	MULTI_MENU, 
}

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
	MessageBus.menu_closed.connect(Callable(self, "close_menu"))
	
	MessageBus.menu_pressed.connect(Callable(self, "toggle_menu"))
	

## Returns the current UILevels state of the UI
func get_menu_state() -> UILevels:
	if not Globals.is_paused:
		return UILevels.NO_UI
	if menu_array.size() == 1:
		return UILevels.PAUSE_MENU
	# unnecessary, but I'm keeping it this way in case I add more states
	else: # menu_array.size() > 1
		return UILevels.MULTI_MENU

## Should be called when the menu button is pressed
func toggle_menu() -> void:
	print(get_menu_state())
	match(get_menu_state()):
		UILevels.NO_UI:
			var is_paused = Globals.toggle_pause()
			pause_menu.show()
		UILevels.PAUSE_MENU:
			var is_paused = Globals.toggle_pause()
			pause_menu.hide()
		UILevels.MULTI_MENU:
			close_outer_menu()
	'''
	var is_paused = Globals.toggle_pause()
	if is_paused:
		pause_menu.show()
	else:
		pause_menu.hide()
	'''

## Called via a signal from some existing menu.  
## [br]
## THIS DOES NOT OPEN PAUSE MENU
func open_menu(menu: PackedScene) -> void:
	var new_menu = menu.instantiate()
	menu_array.append(new_menu)
	ui_parent.add_child(new_menu)

func close_outer_menu() -> void:
	var removed_menu = menu_array[menu_array.size()-1]
	ui_parent.remove_child(removed_menu)
	menu_array.remove_at(menu_array.size()-1)
