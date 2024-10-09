class_name PlayerSubmarine
extends CharacterBody2D

@export var controllers: Array[MovementController]

@onready var velocity_component = $VelocityComponent
@onready var crash_sound: AudioStreamPlayer = $CrashSound

func _process(_delta) -> void:
	if Input.is_action_just_pressed("scan"):
		MessageBus.player_scanned.emit()

func _physics_process(delta) -> void:
	velocity_component.velocity = velocity
	velocity_component.apply_drag(delta)
	velocity_component.apply_thrust(_get_movement_direction(), delta)
	velocity = velocity_component.velocity
	if move_and_slide():
		crash(delta)

## Private function to determine the direction that the sub should be moving 
## based on the inputs of all possible controllers
func _get_movement_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	for controller in controllers:
		direction += controller.get_direction()
	return direction.normalized()

func crash(delta: float) -> void:
	if not crash_sound.playing:
		crash_sound.play()
	var collision: KinematicCollision2D = get_slide_collision(get_slide_collision_count()-1)
	velocity_component.velocity = velocity
	velocity_component.apply_thrust(collision.get_normal(), 0.1, 1)
	velocity = velocity_component.velocity
