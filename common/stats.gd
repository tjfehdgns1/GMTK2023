extends Node
class_name Stats

signal no_health
signal health_changed
signal max_health_changed

@export var max_health := 3 : set = set_max_health
@onready var health := max_health : set = set_health  # if dont use onready -> no update if change in editor

func set_max_health(value):
	max_health = value
	max_health_changed.emit()

func set_health(value):
	health = clamp(value, 0, max_health)
	health_changed.emit()
	if health <= 0:
		no_health.emit()
