## A class for an individual puzzle.  Can be won.
class_name Level
extends GameScene

#var minimap_scene: PackedScene = preload("res://scenes/mini_map/mini_map.tscn")
var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")

## The player
@onready var player_submarine = $PlayerSubmarine
## The zone that sends the player to the next level
@onready var win_zone = $WinZone


## The name of the level
@export var level_name: String = "Unnamed level"
## The level that will be loaded when this one is won
@export var next_level: PackedScene
@export var next_level_text: String = "Level Won!"

var is_paused: bool = false

func _ready() -> void:
	#_initialize_minimap()
	pass

func _process(_delta) -> void:
	if Input.is_action_just_pressed("menu"):
		if not is_paused:
			MessageBus.menu_opened.emit(pause_menu)
			toggle_pause()
		else:
			print(Globals.menu_depth)
			MessageBus.top_menu_closed.emit()
			if Globals.menu_depth < 1:
				toggle_pause()

# TODO: Make level pause
func toggle_pause() -> bool:
	is_paused = not is_paused
	return is_paused

"""
## DEPRECATED
func _initialize_minimap() -> void:
	var minimap: MiniMap = minimap_scene.instantiate()
	minimap.player = player_submarine
	minimap.destination = win_zone
	$CanvasLayer/Control/Panel.add_child(minimap)
"""

## called when something enters the win zone
func _on_win_area_body_entered(body):
	if body == player_submarine:
		MessageBus.game_scene_changed.emit(next_level, next_level_text)
