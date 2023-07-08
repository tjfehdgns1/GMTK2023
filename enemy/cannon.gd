extends Node2D



const ENEMY_BULLET := preload("res://enemy/enemy_bullet.tscn")
const ENEMY_DEATH_EFFECT := preload("res://enemy/enemy_death.tscn")

@onready var stats: Node = $Stats
@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint
@onready var fire_direction: Marker2D = $FireDirection
@export var bullet_speed = 40.0



func fire_bullet():
	var bullet = Utility.instantiate_scene_on_world(ENEMY_BULLET, bullet_spawn_point.global_position) as Projectile
	var direction = global_position.direction_to(fire_direction.global_position)
	var velocity = direction.normalized() * bullet_speed
	velocity.rotated(randf_range(-deg_to_rad(90/2), deg_to_rad(90/2)))
	bullet.speed = velocity.x
	bullet.velocity = velocity



func _on_hurtbox_hurt(hitbox, damage) -> void:
	$Stats.health -= damage
	


func _on_stats_no_health() -> void:
	Utility.instantiate_scene_on_world(ENEMY_DEATH_EFFECT, global_position)
	queue_free()

