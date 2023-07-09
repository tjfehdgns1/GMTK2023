extends Node2D
class_name Projectile


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer



@export var speed := 250.0

var velocity := Vector2.ZERO

const EXPLOSION_EFFECT := preload("res://enemy/enemy_hit_effect.tscn")

func update_velocity() -> void:
	velocity.x = speed
	velocity = velocity.rotated(rotation)


func _process(delta: float) -> void:
	position += velocity * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	Utility.instantiate_scene_on_world(EXPLOSION_EFFECT, global_position)

	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	Utility.instantiate_scene_on_world(EXPLOSION_EFFECT, global_position)

	queue_free()

func play_explosion():
	Sound.play(Sound.explode,1.0,-20.0)
	

