extends Control

var level = "res://World/world.tscn"
var lvl_menu = "res://Title Screen/menu.tscn"

@onready var izra = $Izra
@onready var ishtu = $Ishtu



func _ready():
	# Izra
	izra.lbl_char_sel.text = "Izra"
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = load("res://Assets/Textures/Player/player_sprite.png")
	atlas_texture.region = Rect2(0, 0, 32, 32)  # Adjust as needed
	izra.btn_char_sel.texture_normal = atlas_texture
	izra.btn_char_sel.scale = Vector2(1.1,1.1)
	izra.btn_char_sel.position = Vector2(0,5)
	
	# Ishtu
	ishtu.lbl_char_sel.text = "Ishtu"
	var atlas_texture2 = AtlasTexture.new()
	atlas_texture2.atlas = load("res://Assets/Textures/Player/ishtu/Necromancer_creativekind-Sheet.png")
	atlas_texture2.region = Rect2(1330, 415, 60, 83)  # Adjust as needed
	ishtu.btn_char_sel.texture_normal = atlas_texture2
	ishtu.btn_char_sel.scale = Vector2(0.8,0.8)
	ishtu.btn_char_sel.position = Vector2(10,0)

func _on_btn_back_click_end():
	var _level = get_tree().change_scene_to_file(lvl_menu)


func _on_izra_char_select_click_end():
	Global.selected_character = "izra"
	var _level = get_tree().change_scene_to_file(level)


func _on_ishtu_char_select_click_end():
	Global.selected_character = "ishtu"
	var _level = get_tree().change_scene_to_file(level)
