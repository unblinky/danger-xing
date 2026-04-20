extends Area3D
class_name Vessel

# HACK: Possible code duplication.
var river: River
var speed: float = 0.0 # m/sec. # Decimals

func _ready() -> void:
	# Expecting a River.
	river = get_parent()
	speed = river.speed_limit

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > river.exit_point:
		position.x = river.entrance_point
	
