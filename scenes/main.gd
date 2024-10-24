## The root of the scene tree, this switches game scenes and handles the pause
## menu
class_name Main
extends Node

#var main_menu_scene: GameScene
var current_scene: GameScene

@onready var current_scene_parent: Node = $CurrentSceneParent
@onready var scene_transition: SceneTransition = %SceneTransition
@onready var sound_manager: SoundManager = %SoundManager

func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://visuals/ui/CursorPointing.png"), 
			Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(load("res://visuals/ui/CursorHand.png"), 
			Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(load("res://visuals/ui/CursorHand.png"), 
			Input.CURSOR_POINTING_HAND)
	
	current_scene = current_scene_parent.get_child(0)
	
	MessageBus.game_scene_changed.connect(Callable(self, "change_game_scene"))
	MessageBus.quit_game.connect(Callable(self, "quit_game"))

## Changes the current scene to the specified scene.
func change_game_scene(new_scene: PackedScene, transition_text:="") -> void:
	scene_transition.transition(transition_text)
	await scene_transition.screen_covered
	var initialized_scene: GameScene = new_scene.instantiate()
	current_scene.queue_free()
	current_scene = initialized_scene
	
	#current_scene_parent.call_deferred("add_child", initialized_scene)
	current_scene_parent.add_child(initialized_scene)
	sound_manager.update()

func quit_game() -> void:
	get_tree().quit()
