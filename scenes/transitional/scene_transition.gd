class_name SceneTransition
extends Control

signal screen_covered

@export_group("Fading")
## the amount of time it will take for the screen to fade to black
@export var fade_time: float = 0.5
## the amount of time it will take for the text to unfade once the scene is
## completely black
@export var text_unfade_time: float = 0.2
## the amount of time the scene will remain fully black
@export var display_duration: float = 0.5
## the amount of time it will take for the screen to fade into the next scene
@export var unfade_time: float = 0.5

var tween: Tween

@onready var color_rect = $ColorRect
@onready var text = $Text


func transition(text_to_dislpay: String = "") -> void:
	text.text = text_to_dislpay
	print("transitioning")
	show()
	tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,1), fade_time)
	tween.tween_property(text, "modulate", Color(1,1,1,1), text_unfade_time)
	tween.tween_callback(screen_covered.emit)
	tween.tween_interval(display_duration)
	tween.tween_property(color_rect, "color", Color(0,0,0,0), unfade_time)
	tween.parallel().\
			tween_property(text, "modulate", Color(1,1,1,0), unfade_time)
	tween.tween_callback(hide)
