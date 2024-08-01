extends Button

@onready var snd_hover = $snd_hover
@onready var snd_click = $snd_click

signal click_end()

func _on_mouse_entered():
	snd_hover.play()

func _on_pressed():
	snd_click.play()


func _on_snd_click_finished():
	click_end.emit() 
