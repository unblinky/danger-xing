extends Node
class_name Main

@export var goals: Array[Goal]

func is_game_over() -> bool:
	for goal in goals:
		if not goal.is_occupied:
			return false
	
	return true
