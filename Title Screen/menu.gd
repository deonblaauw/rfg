extends Control

#var level = "res://World/world.tscn"
var lvl_char_sel = "res://Title Screen/character_selection.tscn"

func _on_btn_play_click_end():
	var _level = get_tree().change_scene_to_file(lvl_char_sel)

func _on_btn_quit_click_end():
	get_tree().quit()
