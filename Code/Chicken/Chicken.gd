extends Area3D
class_name Chicken

@onready var graphics: Node3D = $Graphics
@onready var lives_ui: Label = $UI/LivesUI

var lives: int = 8


func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)


func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")
	if area is Car:
		cruched()

func cruched():
	position = Vector3.ZERO
	graphics.rotation_degrees.y = 0
	print("Crushed!")
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)


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
