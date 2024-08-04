extends Control

var level = "res://World/world.tscn"
var lvl_menu = "res://Title Screen/menu.tscn"

@onready var izra = $Izra
@onready var ishtu = $Ishtu
@onready var bob = $Bob

func _ready():
	# Izra setup
	setup_character(izra, "izra", "res://Assets/Textures/Player/izra_icon.png")

	# Ishtu setup
	setup_character(ishtu, "ishtu", "res://Assets/Textures/Player/ishtu_icon.png")

	# Bob setup
	setup_character(bob, "bob", "res://Assets/Textures/Player/bob_icon.png")

func setup_character(char_node, char_name, texture_path):
	char_node.lbl_char_sel.text = char_name.capitalize()
	char_node.lbl_weapon.text = "Weapon: " + CharacterDb.CHARACTERS[char_name]["weapon"]
	char_node.lbl_hp.text = "Health: " + str(CharacterDb.CHARACTERS[char_name]["max_hp"])
	char_node.lbl_speed.text = "Speed: " + str(CharacterDb.CHARACTERS[char_name]["movement_speed"])
	char_node.lbl_healrate.text = "Heal Rate: " + str(CharacterDb.CHARACTERS[char_name]["heal_rate"])
	char_node.icon.texture = load(texture_path)

func _on_btn_back_click_end():
	get_tree().change_scene_to_file(lvl_menu)

func _on_izra_char_select_click_end():
	select_character("izra")

func _on_ishtu_char_select_click_end():
	select_character("ishtu")

func _on_bob_char_select_click_end():
	select_character("bob")

func select_character(char_name):
	Global.selected_character = char_name
	get_tree().change_scene_to_file(level)
