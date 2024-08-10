extends Label

@export var duration: float = 1.0


func _ready():
	visible = false
	
func show_number(pos):
	visible = true
	var tween = create_tween()
	# Animate the position movement
	tween.tween_property(self, "position", pos + Vector2(0, 0), duration)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_OUT)
	
	# Animate the fade-out effect
	tween.tween_property(self, "modulate:a", 0.0, duration)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_OUT)

	await tween.finished
	queue_free()
	

func set_color(color):
	self.add_theme_color_override("font_color", color)

func set_damage(damage_value: int):
	text = str(damage_value)
