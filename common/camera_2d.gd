extends Camera2D

var shake := 0.0


@onready var timer: Timer = $Timer


func _ready() -> void:
	Events.add_screenshake.connect(_start_screenshake)

func _process(delta: float) -> void:
	offset.x = randf_range(-shake, shake)
	offset.y = randf_range(-shake, shake)
	

func _start_screenshake(amount,duration):
	shake = amount
	timer.wait_time = duration
	timer.start()
	pass


func _on_timer_timeout() -> void:
	shake = 0
	pass # Replace with function body.
