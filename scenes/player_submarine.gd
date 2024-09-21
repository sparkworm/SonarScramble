class_name PlayerSubmarine
extends CharacterBody2D

@onready var velocity_component = $VelocityComponent

func _process(_delta) -> void:
	if Input.is_action_just_pressed("scan"):
		MessageBus.player_scanned.emit()

func _physics_process(delta) -> void:
	velocity_component.velocity = velocity
	velocity_component.apply_drag(delta)
	velocity_component.apply_thrust(_get_movement_direction(), delta)
	velocity = velocity_component.velocity
	move_and_slide()

## Private function to determine the direction that the sub should be moving based on the inputs
func _get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
