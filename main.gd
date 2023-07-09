extends Node2D



func _ready() -> void:
	await Musix.fade()
	Musix.play(Musix.in_game, -10.0)
