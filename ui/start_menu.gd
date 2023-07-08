extends Control

@onready var start_button: Button = %StartButton
@onready var option_button: Button = %OptionButton
@onready var quit_button: Button = %QuitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()
	start_button.grab_click_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
