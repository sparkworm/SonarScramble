class_name MovementController
extends Node

signal movement_inputed(direction: Vector2)

## Virtual function for getting the direction
func get_direction() -> Vector2:
	return Vector2.ZERO
