extends Node2D



func _ready() -> void:
	PlayerStats.health = 3
	await Musix.fade()
	Musix.play(Musix.in_game, -20.0)
