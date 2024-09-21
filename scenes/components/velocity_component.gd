class_name VelocityComponent
extends Node

#@export var max_speed: float = 100
@export var thrust: float = 20
@export var mass: float = 1
@export var drag: float = 0.5

var velocity: Vector2

## Performs very basic physics calculations to accelerate by applying thrust
func apply_thrust(thrust_direction: Vector2, delta:float, 
		thrust_fraction:float = 1.0) -> void:
	var thrust_force: Vector2 = thrust * thrust_fraction * thrust_direction
	# this could be aided with some calculus
	velocity += thrust_force / mass * delta

## Performs very basic physics calculations to decelerate due to drag
func apply_drag(delta:float) -> void:
	var drag_force: Vector2 = -velocity * drag
	# this could be aided with some calculus
	velocity += drag_force / mass * delta
	#velocity = velocity/(Vector2(1.0,1.0)+drag_force/mass*delta)
