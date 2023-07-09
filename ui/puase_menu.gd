extends Control


var paused = false : 
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused
	pass


func _on_resume_button_pressed() -> void:
	Sound.play(Sound.click)
	print_debug("resume")
	paused = false
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	Sound.play(Sound.click)
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")
	paused = false
	pass # Replace with function body.
