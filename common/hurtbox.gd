extends Area2D
class_name Hurtbox


signal hurt(hitbox, damage)

var is_invincible = false : set = check_invincible


func take_hit(hitbox, damage):
	if is_invincible : return
	hurt.emit(hitbox, damage)
	
	
func disable(value):
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
	
func check_invincible(value):
	is_invincible = value
	disable.call_deferred(value)
