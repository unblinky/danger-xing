extends PanelContainer
class_name PauseMenu

@onready var message: Label = $VBox/Message
@onready var play_button: Button = $VBox/PlayButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

var main: Main

func _ready() -> void:
	# Signal hooks.
	play_button.pressed.connect(on_play_pressed)
	continue_button.pressed.connect(on_continue_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	main = get_parent()
	
	# TODO: Init() ?
	self.show()
	play_button.show()
	continue_button.hide()
	quit_button.show()


# FIXME: Have to hit the Esc twice?
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = visible
		
		message.text = "Game Paused"
		play_button.hide()
		continue_button.show()
		quit_button.show()

func on_play_pressed():
	main.next_level()
	hide()
	get_tree().paused = false

func on_continue_pressed():
	hide()
	get_tree().paused = false

func on_quit_pressed():
	get_tree().quit()
