extends Area2D
class_name Hitbox


@export var damage := 1




func _on_area_entered(hurtbox : Hurtbox) -> void:
	if !hurtbox is Hurtbox: return
	hurtbox.take_hit(self, damage)
