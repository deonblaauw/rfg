extends ColorRect

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

@onready var lbl_name = $lbl_name
@onready var lbl_description = $lbl_description
@onready var lbl_level = $lbl_level
@onready var item_icon = $ColorRect/ItemIcon
 

signal selected_upgrade(upgrade)
 
func _ready():
	if item == null:
		item = "food"
	# setup items in the Item display
	lbl_name.text = UpgradeDb.UPGRADES[item]["displayname"]
	lbl_description.text = UpgradeDb.UPGRADES[item]["details"]
	lbl_level.text = UpgradeDb.UPGRADES[item]["level"]
	item_icon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	
	# connect the selected_upgrade signal to the upgrade_character function in player script
	connect("selected_upgrade", Callable(player,"upgrade_character"))
	
	
func _input(event):
	if event.is_action("click"):
		if mouse_over:
			selected_upgrade.emit(item)

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
