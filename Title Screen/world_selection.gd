extends Control

@onready var grasslands_tile = $GrasslandsTile
@onready var acacia_tile = $AcaciaTile
@onready var inferius_tile = $InferiusTile

var lvl_menu_char_selection = "res://Title Screen/character_selection.tscn"

var grasslands_scene = "res://World/grasslands_world.tscn"
var acacia_scene = "res://World/acacia_world.tscn"
var inferius_scene = "res://World/infernius_world.tscn"

func _ready():
	# Grasslands setup
	var world_name = "Grasslands"
	var icon_texture_path = "res://Assets/Textures/dirt_full_new.png"
	var description = "Grassy lands, bats and monsters. Grab your pearls!"
	var game_type = "Duration: 5 minutes"
	setup_world_tile(grasslands_tile, world_name, description, game_type, icon_texture_path)
	
	# Acacia setup
	world_name = "Acacia"
	icon_texture_path = "res://Assets/Textures/World/backgrounds 256x256/256_Dirt Muddy 01.png"
	description = "Endless monsters. Stone flooring. What's not to love!?"
	game_type = "Duration: 5 minutes (harder)"
	setup_world_tile(acacia_tile, world_name, description, game_type, icon_texture_path)

	# Infernius setup
	world_name = "Infernius"
	icon_texture_path = "res://Assets/Textures/World/backgrounds 256x256/256_Grass 03 Mud.png"
	description = "Follow your heart, young adventurer. Unless you're Bob, then you're just old."
	game_type = "Duration: 10 minutes (exp)"
	setup_world_tile(inferius_tile, world_name, description, game_type, icon_texture_path)

	
func setup_world_tile(world_node, world_name, description, game_type, icon_texture_path):
	world_node.lbl_title.text = world_name.capitalize()
	world_node.lbl_description.text = description
	world_node.icon.texture = load(icon_texture_path)
	world_node.lbl_game_type.text = game_type
	
func _on_grasslands_world_select_click_end():
	get_tree().change_scene_to_file(grasslands_scene)

func _on_btn_back_click_end():
	get_tree().change_scene_to_file(lvl_menu_char_selection)


func _on_acacia_world_select_click_end():
	get_tree().change_scene_to_file(acacia_scene)


func _on_inferius_tile_world_select_click_end():
	get_tree().change_scene_to_file(inferius_scene)
