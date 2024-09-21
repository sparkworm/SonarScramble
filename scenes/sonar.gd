class_name Sonar
extends Node2D

signal blip_detected(pos: Vector2)

## the number of shots in a scan
@export var num_shots: int = 36
## the length of a scan
@export var scan_time: float = 2.0
## the distance of an individual raycast
@export var ray_length: float = 300.0

var is_scanning: bool = false

@onready var ray = $Ray
## timer that measures how long should be between blips
@onready var blip_timer = $BlipTimer
## timer that measures how long a full scan should be
@onready var scan_timer = $ScanTimer

func _ready():
	MessageBus.player_scanned.connect(Callable(self, "scan"))

## Adds a body to be excluded from the ray's scan [br]
## This doesn't need be done for the vehicle using this sonar, since the ray
## not detect the collision object from the inside
func add_scan_exception(body: CollisionObject2D) -> void:
	ray.add_exception(body)

func _physics_process(delta) -> void:
	if is_scanning:
		ray.rotation += TAU/scan_time * delta

func scan() -> void:
	if is_scanning == true:
		return
	is_scanning = true
	ray.rotation = 0.0
	ray.target_position = Vector2(ray_length, 0.0)
	blip_timer.wait_time = scan_time / num_shots
	# can change this to have repeat scans
	scan_timer.wait_time = scan_time
	blip_timer.start()
	scan_timer.start()

func _on_blip_timer_timeout() -> void:
	if ray.is_colliding():
		blip_detected.emit(ray.get_collision_point() - global_position)
		#$Test_icon.position = ray.get_collision_point() - global_position

func _on_scan_timer_timeout():
	is_scanning = false
	blip_timer.stop()
