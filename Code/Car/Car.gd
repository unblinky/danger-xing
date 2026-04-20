extends Area3D
class_name Car

var lane: Lane
var speed: float = 0.0 # m/sec. # Decimals

func _ready() -> void:
	# Should be Lane.
	lane = get_parent()
	speed = lane.speed_limit

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > lane.exit_point:
		position.x = lane.entrance_point
	
