class_name SonarDisplay
extends Control

@export var sonar: Sonar
@export var blip_scene: PackedScene
@export var display_radius: int = 48
@export var scale_factor: float = 3.0
@export var blip_lifetime: float = 2.0

#@onready var display: Node2D = %Display
@onready var blips = %Blips
@onready var scan_line: Line2D = %ScanLine

func _ready():
	sonar.blip_detected.connect(Callable(self, "draw_blip"))
	scan_line.points[1].x = min(sonar.ray_length / scale_factor, display_radius)

func _process(_delta) -> void:
	if sonar.is_scanning:
		scan_line.rotation = sonar.ray.rotation

func draw_blip(pos: Vector2) -> void:
	if (pos / scale_factor).length() <= display_radius:
		var new_blip: Blip = blip_scene.instantiate()
		new_blip.life_time = blip_lifetime
		new_blip.position = Vector2i(pos / scale_factor)
		blips.add_child(new_blip)
	else:
		print("blip outside of screen")
