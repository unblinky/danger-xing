extends Area3D
class_name Chicken

@onready var graphics: Node3D = $Graphics
@onready var lives_ui: Label = $UI/LivesUI

var lives: int = 8

# Positionoal variables.
var spawning_point: Vector3
var from: Vector3
var to: Vector3
var weight: float = 1.0 # We're already there.
var lerp_speed: float = 2.0 # m/s lerp

func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)
	spawning_point = position
	from = spawning_point
	to = spawning_point

func _process(delta: float) -> void:
	if weight >= 1.0:
		if Input.is_action_just_pressed("move_left"):
			from = position
			to = position + Vector3.LEFT
			weight = 0.0
			graphics.rotation_degrees.y = 90.0
		
		if Input.is_action_just_pressed("move_right"):
			from = position
			to = position + Vector3.RIGHT
			weight = 0.0
			graphics.rotation_degrees.y = -90.0
		
		if Input.is_action_just_pressed("move_forward"):
			from = position
			to = position + Vector3.FORWARD
			weight = 0.0
			graphics.rotation_degrees.y = 0.0
		
		if Input.is_action_just_pressed("move_back"):
			from = position
			to = position + Vector3.BACK
			weight = 0.0
			graphics.rotation_degrees.y = 180.0
	
	if weight < 1.0:
		# Update our position
		weight += lerp_speed * delta
	else:
		# Stop the lerp.
		weight = 1.0
		from = to
	
	position = lerp(from, to, weight)


func destroy():
	position = spawning_point
	graphics.rotation_degrees.y = 0
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)


func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")

	if area is Car:
		destroy()

	if area is Vessel:
		print("Riding on a Vessel.")

	if area is River:
		destroy()
		print("Hit the river.")
