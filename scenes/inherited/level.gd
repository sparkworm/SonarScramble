## A class for an individual puzzle.  Can be won.
class_name Level
extends GameScene

var minimap_scene: PackedScene = preload("res://scenes/mini_map/mini_map.tscn")

## The player
@onready var player_submarine = $PlayerSubmarine
## The zone that sends the player to the next level
@onready var win_zone = $WinZone


## The name of the level
@export var level_name: String = "Unnamed level"
## The level that will be loaded when this one is won
@export var next_level: PackedScene

func _ready() -> void:
	_initialize_minimap()

func _initialize_minimap() -> void:
	var minimap: MiniMap = minimap_scene.instantiate()
	minimap.player = player_submarine
	minimap.destination = win_zone
	$CanvasLayer/Control/Panel.add_child(minimap)

## called when something enters the win zone
func _on_win_area_body_entered(body):
	if body == player_submarine:
		print("level won!")
		MessageBus.game_scene_changed.emit(next_level)
