extends ColorRect

@onready var lbl_description = $lbl_description
@onready var lbl_title = $lbl_title
@onready var icon = $Icon
@onready var lbl_game_type = $lbl_game_type

@onready var snd_hover = $snd_hover
@onready var snd_click = $snd_click

signal world_select_click_end()

func _on_snd_click_finished():
	world_select_click_end.emit()


func _on_btn_select_pressed():
	snd_click.play()


func _on_btn_select_mouse_entered():
	snd_hover.play()


func _on_btn_select_mouse_exited():
	pass # Replace with function body.
