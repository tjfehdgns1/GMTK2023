extends CharacterBody2D
class_name Player_movement


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
@onready var player_sprite: Sprite2D = $PlayerSprite



var pre_input := 0.0



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
		if velocity.y < 0:
			animation_player.play("jump")


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

		if Input.is_action_just_pressed("jump"):
			can_jump_buffer = true
			jump_buffer_timer.start()

	
	
	pass
func jump(jump_velocity):
	velocity.y = jump_velocity

func _on_jump_buffer_timer_timeout() -> void:
	can_jump_buffer = false









