extends Area2D

# HurtBox: I'm Hurting

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0 
@onready var collision = $CollisionShape2D
@onready var cooldown_timer = $cooldownTimer

signal hurt(damage)

# the hurtbox is trying to detect the hitbox here
func _on_area_entered(attacker):
	if attacker.is_in_group("attack"): # hitbox is in group attack
		if not attacker.get("damage") == null: # check if variable exists
			match HurtBoxType:
				0: #Cooldown
					collision.call_deferred("set","disabled",true)
					cooldown_timer.start()
				1: #HitOnce
					pass
				2: #DisableHitBox
					if attacker.has_method("tempDisable"):
						attacker.tempDisable()
			var damage = attacker.damage
			hurt.emit(damage)


func _on_cooldown_timer_timeout():
	collision.call_deferred("set","disabled",false ) # re-enable collision shape
