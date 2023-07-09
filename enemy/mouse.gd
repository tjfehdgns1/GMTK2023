extends CharacterBody2D


@export var turn_at_ledge := false
@export var speed := 30.0
@export var jump_height := 50.0
@export var jump_peak_time := 0.35
#@export var jump_descent_time := 0.3
#@onready var jump_velocity := ((2.0 * jump_height) / (jump_peak_time)) * -1.0
@onready var gravity := ((-2.0 * jump_height) / (jump_peak_time * jump_peak_time)) * -1.0


@onready var enemy_sprite: Sprite2D = $EnemySprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_cast: RayCast2D = $FloorCast


const ENEMY_DEATH_EFFECT := preload("res://enemy/enemy_death.tscn")

@export var move_x := 1

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		animation_player.play("run")
		
	if is_on_wall():
		turn_around()
	
	if is_at_ledge() and turn_at_ledge:
		turn_around()
	
	velocity.x = move_x * speed
	enemy_sprite.scale.x = move_x
			
	move_and_slide()
	
	
func turn_around():
	move_x *= -1


func is_at_ledge():
	return is_on_floor() and !floor_cast.is_colliding()
	


func _on_hurtbox_hurt(hitbox, damage) -> void:
	$Stats.health -= damage
	Sound.play(Sound.hurt,1.0,-20.0)
	print_debug("mouse hurt")
	


func _on_stats_no_health() -> void:
	Utility.instantiate_scene_on_world(ENEMY_DEATH_EFFECT, global_position)
	Sound.play(Sound.explode)
	queue_free()


func _on_finish_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
