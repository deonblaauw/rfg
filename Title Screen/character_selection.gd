extends Control

var lvl_menu = "res://Title Screen/menu.tscn"
var lvl_menu_world_selection = "res://Title Screen/world_selection.tscn"

@onready var izra = $Izra
@onready var ishtu = $Ishtu
@onready var bob = $Bob
@onready var samurai = $Samurai
@onready var smash_knight = $SmashKinght

func _ready():
	# Izra setup
	setup_character(izra, "izra", "res://Assets/Textures/Player/SpriteSheets/RogueArcher.png")

	# Ishtu setup
	setup_character(ishtu, "ishtu", "res://Assets/Textures/Player/ishtu_icon.png")

	# Bob setup
	setup_character(bob, "bob", "res://Assets/Textures/Player/bob_icon.png")
	
	# Samurai setup
	setup_character(samurai, "samurai", "res://Assets/Textures/Player/samurai_icon.png")
	
	# SmashKnight setup"res://Assets/Textures/Player/icons/smash_knight_icon.png"
	setup_character(smash_knight, "smash_knight", "res://Assets/Textures/Player/SpriteSheets/SmashKnight.png")
	

func setup_character(char_node, char_name, texture_path):
	char_node.lbl_char_sel.text = char_name.capitalize()
	char_node.lbl_weapon.text = "Weapon: " + CharacterDb.CHARACTERS[char_name]["weapon"]
	char_node.lbl_hp.text = "Health: " + str(CharacterDb.CHARACTERS[char_name]["max_hp"])
	char_node.lbl_speed.text = "Speed: " + str(CharacterDb.CHARACTERS[char_name]["movement_speed"])
	char_node.lbl_healrate.text = "Heal Rate: " + str(CharacterDb.CHARACTERS[char_name]["heal_rate"])

	# Load the sprite sheet texture
	var sprite_sheet = load(texture_path)
	if sprite_sheet == null:
		print("Failed to load texture: ", texture_path)
		return

	# Set the texture to the Sprite2D
	char_node.sprite_2d.texture = sprite_sheet


func select_character(char_name):
	Global.selected_character = char_name
	get_tree().change_scene_to_file(lvl_menu_world_selection)
	
func _on_btn_back_click_end():
	get_tree().change_scene_to_file(lvl_menu)

func _on_izra_char_select_click_end():
	select_character("izra")

func _on_ishtu_char_select_click_end():
	select_character("ishtu")

func _on_bob_char_select_click_end():
	select_character("bob")

func _on_samurai_char_select_click_end():
	select_character("samurai")


func _on_smash_kinght_char_select_click_end():
	select_character("smash_knight")

