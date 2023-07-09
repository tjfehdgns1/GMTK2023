extends Control

@onready var start_button: Button = %StartButton
@onready var option_button: Button = %OptionButton
@onready var quit_button: Button = %QuitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Musix.fade()
	Musix.play(Musix.main_theme, -30.0)
	start_button.grab_focus()
	start_button.grab_click_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_start_button_pressed() -> void:
	Sound.play(Sound.click)
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.


func _on_option_button_pressed() -> void:
	Sound.play(Sound.click)
	print_debug("option pressed")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	Sound.play(Sound.click)
	get_tree().quit()
	pass # Replace with function body.
