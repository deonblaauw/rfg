extends ColorRect

@onready var snd_hover = $snd_hover
@onready var snd_click = $snd_click

func _on_btn_izra_mouse_entered():
	snd_hover.play()
	modulate = Color(0.8, 0.8, 0.8)


func _on_btn_izra_mouse_exited():
	modulate = Color(1.0, 1.0, 1.0)
