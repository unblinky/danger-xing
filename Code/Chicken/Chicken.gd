extends Area3D
class_name Chicken

@onready var collider: CollisionShape3D = $Collider
@onready var graphics: Node3D = $Graphics
@onready var lives_ui: Label = $UI/LivesUI

@export var lerp_speed: float = 8.0 # m/s lerp

var lives: int = 3

# Positionoal variables.
var spawning_point: Vector3
var from: Vector3
var to: Vector3
var weight: float = 1.0 # We're already there.


var riding_vessel: Vessel = null

var main: Main

func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)
	spawning_point = position
	from = spawning_point
	to = spawning_point
	
	# HACK: Parents....
	main = get_parent().get_parent()

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
		collider.set_deferred("disabled", false)
	
	if riding_vessel != null:
		position = riding_vessel.global_position


func reposition_to_spawn():
	from = position
	to = spawning_point
	weight = 0.0
	graphics.hide()
	collider.set_deferred("disabled", true)


func destroy():
	reposition_to_spawn()
	graphics.rotation_degrees.y = 0
	update_lives(-1)


func update_lives(delta_lives: int):
	lives += delta_lives
	if lives < 0:
		# TODO: Game Over
		main.game_over()
		lives = 0
	
	lives_ui.text = "Lives: " + str(lives)


func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")
		area.occupy()
		reposition_to_spawn()
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
