class_name MiniMap
extends TextureRect

## the amount of time that is waited between updates
@export var update_wait_time: float = 0.1
@export_group("Display")
@export var player: Node2D
@export var destination: Node2D
@export var scale_factor: float = 10
#@export var other_locations: Array[Node2D] # currently unused

@onready var player_icon: Sprite2D = %Player
@onready var destination_icon: Sprite2D = %Destination
@onready var update_timer: Timer = %UpdateTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_timer.wait_time = update_wait_time
	update_timer.start()
	_on_update_timer_timeout()

func _on_update_timer_timeout():
	player_icon.position = player.position / scale_factor
	destination_icon.position = destination.position / scale_factor
	
