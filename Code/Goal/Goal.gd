extends Area3D
class_name Goal

@onready var chicken: Node3D = $Chicken
@onready var beak: MeshInstance3D = $Chicken/Beak

var is_occupied: bool = false

func _ready() -> void:
	chicken.hide()

# TODO:
# - [ ] Jitter during the occupy().
# - [x] Show chicken.
# - [ ] Does the player care?

func occupy():
	chicken.show()
	is_occupied = true
