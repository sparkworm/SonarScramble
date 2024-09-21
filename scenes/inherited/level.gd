## A class for an individual puzzle.  Can be won.
class_name Level
extends GameScene

## The player
@onready var player_submarine = $PlayerSubmarine
## The name of the level
@export var level_name: String = "Unnamed level"
## The level that will be loaded when this one is won
@export var next_level: PackedScene

## called when something enters the win zone
func _on_win_area_body_entered(body):
	if body == player_submarine:
		print("level won!")
		MessageBus.game_scene_changed.emit(next_level)
