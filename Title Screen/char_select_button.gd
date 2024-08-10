extends ColorRect

@onready var snd_hover = $snd_hover
@onready var snd_click = $snd_click
@onready var lbl_char_sel = $lbl_charSel
@onready var lbl_weapon = $lbl_weapon
@onready var lbl_hp = $lbl_hp
@onready var lbl_speed = $lbl_speed
@onready var lbl_healrate = $lbl_healrate
@onready var icon = $Icon

signal char_select_click_end()
	
func _on_snd_click_finished():
	char_select_click_end.emit()

func _on_btn_select_mouse_entered():
	snd_hover.play()

func _on_btn_select_mouse_exited():
	pass
	
func _on_btn_select_pressed():
	snd_click.play()
