extends Area3D
class_name Chicken

@onready var graphics: Node3D = $Graphics


func _ready() -> void:
	area_entered.connect(on_collision)


func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")
	
	# TODO: Add more collision types.
	#if area is Bus:
		#print("Goal!!!!")


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
