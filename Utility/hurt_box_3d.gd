extends Area3D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0
@onready var collision = $CollisionShape3D
@onready var cooldown_timer = $cooldownTimer

signal hurt(damage: int, angle: Vector3, knockback_amount: float)

var hit_once_array = []

# The hurtbox is trying to detect the hitbox here
func _on_area_entered(attacker: Area3D) -> void:
	if attacker.is_in_group("attack"): # Hitbox is in group attack
		if not attacker.get("damage") == null: # Check if variable exists
			match HurtBoxType:
				0: # Cooldown
					collision.call_deferred("set", "disabled", true)
					cooldown_timer.start()
				1: # HitOnce
					if hit_once_array.has(attacker) == false:
						hit_once_array.append(attacker)
						if attacker.has_signal("remove_from_array"):
							if not is_connected("remove_from_array", Callable(self, "remove_from_list")):
								attacker.connect("remove_from_array", Callable(self, "remove_from_list"))
					else:
						return
				2: # DisableHitBox
					if attacker.has_method("tempDisable"):
						attacker.tempDisable()

			# Apply damage and knockback
			var damage = attacker.damage
			var angle = Vector3.ZERO
			var knockback = 1.0

			# Check if they exist before assigning (defensive programming)
			if not attacker.get("angle") == null:
				angle = attacker.angle
			if not attacker.get("knockback_amount") == null:
				knockback = attacker.knockback_amount

			hurt.emit(damage, angle, knockback)
			if attacker.has_method("enemy_hit"):
				attacker.enemy_hit(1)

func remove_from_list(object: Area3D) -> void:
	if hit_once_array.has(object):
		hit_once_array.erase(object)

func _on_cooldown_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false) # Re-enable collision shape
