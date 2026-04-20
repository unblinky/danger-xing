extends Area3D
class_name Chicken

@onready var graphics: Node3D = $Graphics
@onready var lives_ui: Label = $UI/LivesUI

var lives: int = 8

# Positionoal variables.
var spawning_point: Vector3
var from: Vector3
var to: Vector3

func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)
	spawning_point = position
	from = spawning_point
	to = spawning_point


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		position.x -= 1
		graphics.rotation_degrees.y = 90
	
	if Input.is_action_just_pressed("move_right"):
		position.x += 1
		graphics.rotation_degrees.y = -90
	
	if Input.is_action_just_pressed("move_fore"):
		position.z -= 1
		graphics.rotation_degrees.y = 0
	
	if Input.is_action_just_pressed("move_back"):
		position.z += 1
		graphics.rotation_degrees.y = 180


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
