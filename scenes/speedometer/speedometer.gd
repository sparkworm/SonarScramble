class_name Speedometer
extends Control

@export var player: CharacterBody2D
@export var scale_factor: float = 1
@export var line_max_length: float = 48
@export var update_wait_time: float = 0.05

@onready var speed_line: Line2D = %SpeedLine

func _ready() -> void:
	%UpdateTimer.wait_time = update_wait_time
	%UpdateTimer.start()

func update_velocity(new_velocity: Vector2) -> void:
	new_velocity /= scale_factor
	speed_line.points[1].x = min(line_max_length, new_velocity.length())
	speed_line.rotation = new_velocity.angle()

func _on_update_timer_timeout():
	update_velocity(player.velocity)
