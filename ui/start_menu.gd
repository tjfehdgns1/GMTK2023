extends Control

@onready var start_button: Button = %StartButton
@onready var option_button: Button = %OptionButton
@onready var quit_button: Button = %QuitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_button.button_up:
		get_tree().change_scene_to_file("res://main.tscn")
		
