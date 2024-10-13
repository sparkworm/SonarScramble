class_name Blip
extends Sprite2D

## the range in either direction that the pitch can vary
@export var pitch_variance: float = 0.25

var life_time

## audio stream player for blip sound
## is 2d so that blips can come from the appropriate directions
@onready var blip_sound: AudioStreamPlayer2D = $BlipSound

func _ready() -> void:
	var base_pitch_scale: float = blip_sound.pitch_scale
	blip_sound.volume_db = Settings.sound_settings["sfx_scan"]
	blip_sound.pitch_scale = lerp(base_pitch_scale-pitch_variance, 
			base_pitch_scale+pitch_variance,
			1 - position.length() / blip_sound.max_distance)
	blip_sound.play()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1.0,1.0,1.0,0.0), life_time)
	tween.tween_callback(Callable(self, "queue_free"))
