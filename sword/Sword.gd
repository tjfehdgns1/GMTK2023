extends CharacterBody2D


@export var max_speed := 100.0
@export var acceleration := 600.0
@export var deceleration := 400.0
var move_x := 0.0

@export var jump_height := 60.0
@export var jump_peak_time := 0.35
@export var jump_descent_time := 0.3
@onready var jump_velocity := ((2.0 * jump_height) / (jump_peak_time)) * -1.0
@onready var jump_gravity := ((-2.0 * jump_height) / (jump_peak_time * jump_peak_time)) * -1.0
@onready var fall_gravity := ((-2.0 * jump_height) / (jump_descent_time * jump_descent_time)) * -1.0
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
var can_jump_buffer := false
var jumped := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $SwordSprite
@onready var hurtbox: Area2D = $Hurtbox
@onready var camera_2d: Camera2D = $Camera2D
@onready var attack_animation_player: AnimationPlayer = $AttackAnimationPlayer
@onready var blink_animation_player: AnimationPlayer = $BlinkAnimationPlayer



var pre_input := 0.0


const DUST_EFFECT := preload("res://common/dust.tscn")
const JUMP_EFFECT := preload("res://player/jump_effect.tscn")
const PLAYER_HIT_EFFECT := preload("res://player/player_hit_effect.tscn")


func _ready() -> void:
	PlayerStats.no_health.connect(_die)
	
	
	hurtbox.is_invincible = true
	await get_tree().create_timer(1.0).timeout
	hurtbox.is_invincible = false

func _physics_process(delta: float) -> void:
	
	move_x = Input.get_axis("move_left", "move_right")
	
	apply_gravity(delta)
	apply_acceleration(delta, move_x)
	apply_deceleration(delta, move_x)
	
	pre_input = move_x
	update_animation(move_x)
	var after_input := move_x
	
	var was_on_floor := is_on_floor()
	move_and_slide()
	var just_left_ledge := was_on_floor and !is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_timer.start()

	handle_jump()
#	attack()

	
func update_animation(input_x):
	if input_x != 0:
		player_sprite.scale.x = input_x
	if abs(player_sprite.scale.x) != 1: player_sprite.scale.x = -1
	if input_x != 0:
		if input_x > 0:
			player_sprite.set_rotation_degrees(-5.0)
		elif input_x < 0:
			player_sprite.set_rotation_degrees(5.0)
		else:
			player_sprite.set_rotation_degrees(0.0)
		animation_player.play("run")
	else:
		animation_player.play("idle")
	
	if !is_on_floor():
		if velocity.y < 0 and jumped:
			animation_player.play("jump")


func create_dust_effect():
	Utility.instantiate_scene_on_world(DUST_EFFECT, global_position)
	Sound.play(Sound.footstep,1.0,-10.0)


func create_jump_effect():
	Utility.instantiate_scene_on_world(JUMP_EFFECT, global_position)
	print_debug("jump")
#	Sound.play(Sound.jump,1,-30.0)
	





func apply_gravity(delta):
	var gravity := fall_gravity
	if velocity.y < 0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity
	velocity.y += gravity * delta


func apply_acceleration(delta, input_x):
#	if !is_on_floor(): return
	if input_x != 0:
		velocity.x = move_toward(velocity.x, max_speed * input_x, acceleration * delta)


func apply_deceleration(delta, input_x):
	if input_x == 0: # and is_on_floor()
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)


func handle_jump():
	if is_on_floor(): jumped = false
	
	if is_on_floor() or coyote_timer.time_left > 0.0 and !jumped:
			if Input.is_action_just_pressed("jump"):
				coyote_timer.stop()
				jumped = true
				velocity.y = jump_velocity
			# power jump
			elif can_jump_buffer:
				can_jump_buffer = false
				jumped = true
				velocity.y = jump_velocity * 1.2
				
	elif !is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < jump_velocity/ 2 :
			jumped = true
			velocity.y = jump_velocity / 2
			Sound.play(Sound.swing)

		if Input.is_action_just_pressed("jump"):
			can_jump_buffer = true
			jump_buffer_timer.start()
			Sound.play(Sound.swing)

	
	
	pass
func jump(jump_velocity):
	velocity.y = jump_velocity

func _on_jump_buffer_timer_timeout() -> void:
	can_jump_buffer = false



#
#func attack():
#	if Input.is_action_just_pressed("attack"):
#		attack_animation_player.play("attack")
#
#func attack_sound():
#		Sound.play(Sound.swing)






func _on_hurtbox_hurt(hitbox, damage) -> void:
	Events.add_screenshake.emit(2, 0.1)
	Sound.play(Sound.die)
	PlayerStats.health -= damage
	hurtbox.is_invincible = true
	blink_animation_player.play("blink")
	await get_tree().create_timer(1.0).timeout
	hurtbox.is_invincible = false
	print_debug("player hurt")
	
	
	
	
	
	
	
func _die():
	camera_2d.reparent(get_tree().current_scene)
	Utility.instantiate_scene_on_world(PLAYER_HIT_EFFECT, global_position)
	get_tree().change_scene_to_file("res://ui/game_over_menu.tscn")
	
	
	

	
