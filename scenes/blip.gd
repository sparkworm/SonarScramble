class_name Blip
extends Sprite2D

var life_time

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1.0,1.0,1.0,0.0), life_time)
	tween.tween_callback(Callable(self, "queue_free"))
