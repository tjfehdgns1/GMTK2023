extends Node2D


enum DIRECTION {LEFT = -1, RIGHT = 1}

@export var max_speed := 50.0
@export var crawling_direction = DIRECTION.RIGHT

@onready var floor_cast: RayCast2D = $FloorCast
@onready var wall_cast: RayCast2D = $WallCast


@onready var stats: Node = $Stats


const ENEMY_DEATH_EFFECT := preload("res://enemy/enemy_death.tscn")



func _ready() -> void:
	wall_cast.target_position.x *= crawling_direction
	
func _physics_process(delta: float) -> void:
	if wall_cast.is_colliding():
		global_position = wall_cast.get_collision_point()
		var wall_normal = wall_cast.get_collision_normal()
		rotation = wall_normal.rotated(deg_to_rad(90)).angle()
	else:
		floor_cast.rotation_degrees = -max_speed * crawling_direction * delta
		
		if floor_cast.is_colliding():
			global_position = floor_cast.get_collision_point()
			var floor_normal = floor_cast.get_collision_normal()
			rotation = floor_normal.rotated(deg_to_rad(90)).angle()
		else:
			rotation_degrees += crawling_direction * 4
			



func _on_stats_no_health() -> void:
	Utility.instantiate_scene_on_world(ENEMY_DEATH_EFFECT, global_position)
	Sound.play(Sound.explode)
	queue_free()
	pass # Replace with function body.


func _on_hurtbox_hurt(hitbox, damage) -> void:
	stats.health -= damage
	Sound.play(Sound.hurt,1.0,-20.0)
	pass # Replace with function body.
