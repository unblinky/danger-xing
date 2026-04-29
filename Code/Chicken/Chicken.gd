extends Area3D
class_name Chicken

@onready var graphics: Node3D = $Graphics
@onready var lives_ui: Label = $UI/LivesUI

@export var lerp_speed: float = 8.0 # m/s lerp

var lives: int = 8

# Positionoal variables.
var spawning_point: Vector3
var from: Vector3
var to: Vector3
var weight: float = 1.0 # We're already there.


var riding_vessel: Vessel = null


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
			riding_vessel = null
			
			from = position
			to = position + Vector3.FORWARD
			to = to.round()
			
			weight = 0.0
			graphics.rotation_degrees.y = 0.0
		
		if Input.is_action_just_pressed("move_back"):
			riding_vessel = null
			
			from = position
			to = position + Vector3.BACK
			to = to.round()
			
			weight = 0.0
			graphics.rotation_degrees.y = 180.0
	
	if weight < 1.0:
		# Update our position
		weight += lerp_speed * delta
		## Lerp the position.
		position = lerp(from, to, weight)
	else:
		# Stop the lerp.
		weight = 1.0
		from = to
		graphics.show()
	
	if riding_vessel != null:
		position = riding_vessel.global_position


func rabbit_hole():
	from = position
	to = spawning_point
	weight = 0.0
	graphics.hide()


func destroy():
	rabbit_hole()
	graphics.rotation_degrees.y = 0
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)


func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")
		area.occupy()
		rabbit_hole()
		get_parent().is_level_complete()
	
	if area is Car:
		print("Hit by car.")
		destroy()
	
	if area is Vessel:
		print("Riding on a Vessel.")
		riding_vessel = area
	
	if area is River:
		print("Hit the river.")
		if riding_vessel == null:
			destroy()
