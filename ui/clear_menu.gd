extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/CenterContainer/VBoxContainer/QuitButton.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")
	pass # Replace with function body.
