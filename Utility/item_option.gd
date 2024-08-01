extends ColorRect

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)
 
func _ready():
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
