extends Node3D
class_name Level

# TODO: Not Scalable
# - @export?
@onready var goal_a: Goal = $GoalA
@onready var goal_b: Goal = $GoalB
@onready var goal_c: Goal = $GoalC

var main: Main
var goals: Array[Goal]

func _ready() -> void:
	main = get_parent()
	goals.append(goal_a) # [0]
	goals.append(goal_b) # [1]
	goals.append(goal_c) # [2]

func is_level_complete() -> bool:
	if goals.size() <= 0:
		print("No elements in the array: goals")
		return false
	
	for goal in goals:
		if not goal.is_occupied:
			print ("Still more to go.")
			return false
	
	print("Level Complete")
	main.next_level()
	return true
