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
	show_opening_layout()

func _process(delta: float) -> void:
	# Toggle the menu visibility.
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = visible
		show_paused_layout()

func show_opening_layout():
	message.text = "Danger X-ing"
	play_button.show()
	continue_button.hide()
	quit_button.show()

func show_game_over_layout():
	message.text = "Game Over - Play Again?"
	play_button.show()
	continue_button.hide()
	quit_button.show()

func show_paused_layout():
	message.text = "Game Paused"
	play_button.hide()
	continue_button.show()
	quit_button.show()
	

func on_play_pressed():
	hide()

func on_continue_pressed():
	get_tree().paused = false
	hide()

func on_quit_pressed():
	get_tree().quit()
