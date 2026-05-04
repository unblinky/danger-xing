extends Node
class_name Main

# Level Files.
const CHICKEN_LESS = preload("res://Levels/ChickenLess.tscn")
const SUNNY_DAY = preload("res://Levels/SunnyDay.tscn")
const ROSE_GARDEN = preload("res://Levels/RoseGarden.tscn")
const GARDEN_HOME = preload("res://Levels/GardenHome.tscn")

@onready var pause_menu: PauseMenu = $PauseMenu

var level_files: Array[PackedScene]
var file_index = 0

var level: Level = null

func _ready() -> void:
	# Level Order.
	level_files.append(CHICKEN_LESS) # level_files[0]
	level_files.append(SUNNY_DAY)    # level_files[1]
	level_files.append(ROSE_GARDEN)  # level_files[2]
	level_files.append(GARDEN_HOME)  # level_files[3]
	load_level(CHICKEN_LESS)

func load_level(scene: PackedScene):
	if level != null:
		level.queue_free()
	level = scene.instantiate()
	add_child(level)

func next_level():
	file_index += 1
	
	if file_index > level_files.size() - 1:
		file_index = 0
	load_level(level_files[file_index])

func game_over():
	print("Game Over")
	file_index = 0
	load_level(CHICKEN_LESS)
	
	# TODO: Clean: pause_menu.set_state_gameover()
	pause_menu.message.text = "Game Over"
	pause_menu.play_button.show()
	pause_menu.continue_button.hide()
	pause_menu.quit_button.show()
	pause_menu.show()
	
