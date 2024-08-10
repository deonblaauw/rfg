extends Label

# The duration of the damage number's existence
@export var duration: float = 1.0

func _ready():
	# Animate the movement and fade out of the damage number
	$Tween.tween_property(self, "position", position + Vector2(0, -50), duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.tween_property(self, "modulate:a", 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	# Wait for the tween to complete, then free the instance
	await $Tween.finished
	queue_free()

func set_damage(damage_value: int):
	text = str(damage_value)
