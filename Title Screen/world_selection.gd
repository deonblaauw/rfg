extends Control
@onready var grasslands_tile = $Grasslands
@onready var acacia_tile = $Acacia

var lvl_menu_char_selection = "res://Title Screen/character_selection.tscn"

var grasslands_scene = "res://World/grasslands_world.tscn"
var acacia_scene = "res://World/acacia_world.tscn"

func _ready():
	# Grasslands setup
	var world_name = "Grasslands"
	var texture_path = "res://Assets/Textures/dirt_full_new.png"
	var description = "Grassy lands, bats and monsters. Grab your pearls!"
	var game_type = "Duration: 5 minutes"
	setup_world_tile(grasslands_tile, world_name, description, game_type, texture_path)
	
	# Acacia setup
	world_name = "Acacia"
	texture_path = "res://Assets/Textures/World/backgrounds 256x256/256_Dirt Muddy 01.png"
	description = "Endless monsters. Stone flooring. What's not to love!?"
	game_type = "Duration: 5 minutes (harder)"
	setup_world_tile(acacia_tile, world_name, description, game_type, texture_path)

	
func setup_world_tile(world_node, world_name, description, game_type, texture_path):
	world_node.lbl_title.text = world_name.capitalize()
	world_node.lbl_description.text = description
	world_node.icon.texture = load(texture_path)
	world_node.lbl_game_type.text = game_type
	
func _on_grasslands_world_select_click_end():
	get_tree().change_scene_to_file(grasslands_scene)

func _on_btn_back_click_end():
	get_tree().change_scene_to_file(lvl_menu_char_selection)


func _on_acacia_world_select_click_end():
	get_tree().change_scene_to_file(acacia_scene)
