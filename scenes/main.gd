## The root of the scene tree, this switches game scenes and handles the pause
## menu
class_name Main
extends Node

#var main_menu_scene: GameScene
var current_scene: GameScene

@onready var current_scene_parent: Node = $CurrentSceneParent

func _ready() -> void:
	current_scene = current_scene_parent.get_child(0)
	MessageBus.game_scene_changed.connect(Callable(self, "change_game_scene"))
	MessageBus.quit_game.connect(Callable(self, "quit_game"))

## Changes the current scene to the specified scene.
func change_game_scene(new_scene: PackedScene) -> void:
	#current_scene_parent.remove_child(current_scene)
	current_scene_parent.get_child(0).queue_free()
	var initialized_scene: GameScene = new_scene.instantiate()
	current_scene_parent.call_deferred("add_child", initialized_scene)

func quit_game() -> void:
	get_tree().quit()
