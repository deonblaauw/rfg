extends Control

var level = "res://World/world.tscn"
var lvl_menu = "res://Title Screen/menu.tscn"

@onready var btn_izra = $Izra/btn_izra
@onready var btn_ishtu = $Ishtu/btn_ishtu


func _on_btn_back_click_end():
	var _level = get_tree().change_scene_to_file(lvl_menu)


func _on_btn_izra_pressed():
	Global.selected_character = "izra"
	var _level = get_tree().change_scene_to_file(level)


func _on_btn_ishtu_pressed():
	Global.selected_character = "ishtu"
	var _level = get_tree().change_scene_to_file(level)



