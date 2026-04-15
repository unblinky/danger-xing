extends Area3D
class_name Car

var lane: Lane
var speed: float = 0.0 # m/sec. # Decimals
#var age: int = 0 # Whole numbers
#var nameers: String = "Kyle"
#var is_a_nice_guy: bool = true

func _ready() -> void:
	# Should be Lane.
	lane = get_parent()
	speed = lane.speed_limit

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > lane.exit_point:
		position.x = lane.entrance_point
	
