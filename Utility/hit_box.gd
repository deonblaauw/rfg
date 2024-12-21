extends Area2D

# HitBox: I'm Hitting

var damage = 1
@onready var disable_timer = $disableHitBoxTimer
@onready var collision = $CollisionShape2D

func tempDisable():
	collision.call_deferred("set","disabled",true)
	disable_timer.start()


func _on_disable_hit_box_timer_timeout():
	collision.call_deferred("set","disabled",false) # re-enable collision shape
