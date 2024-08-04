extends ColorRect

@onready var snd_hover = $snd_hover
@onready var snd_click = $snd_click
@onready var lbl_char_sel = $lbl_charSel
@onready var btn_char_sel = $btn_charSel
@onready var lbl_weapon = $lbl_weapon
@onready var lbl_hp = $lbl_hp
@onready var lbl_speed = $lbl_speed
@onready var lbl_healrate = $lbl_healrate

signal char_select_click_end()
	
func _on_snd_click_finished():
	char_select_click_end.emit()

func _on_btn_char_sel_mouse_entered():
	snd_hover.play()
	modulate = Color(0.8, 0.8, 0.8)

func _on_btn_char_sel_mouse_exited():
	modulate = Color(1.0, 1.0, 1.0)

func _on_btn_char_sel_pressed():
	snd_click.play()
