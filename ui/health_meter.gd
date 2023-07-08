extends Control

@onready var empty: TextureRect = $Empty
@onready var full: TextureRect = $Full




func _ready() -> void:
	update_health_ui()
	update_max_health_ui()
	PlayerStats.health_changed.connect(update_health_ui)
	PlayerStats.max_health_changed.connect(update_max_health_ui)

func _process(delta: float) -> void:
	pass


func update_health_ui():
	full.size.x = PlayerStats.health * 16
	pass
func update_max_health_ui():
	empty.size.x = PlayerStats.health * 16
	
