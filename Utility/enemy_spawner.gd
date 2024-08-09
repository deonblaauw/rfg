extends Node2D

@export var spawn_data_resource: Resource

@onready var player = get_tree().get_first_node_in_group("player")
var time = 0

signal changetime(time)

func _ready():
	connect("changetime", Callable(player, "change_time"))

func _on_timer_timeout():
	time += 1
	spawn_enemies()
	changetime.emit(time)
	
func spawn_enemies():
	if not spawn_data_resource:
		return

	var spawn_data = spawn_data_resource.spawn_data
	
	for spawn_info in spawn_data:
		if time >= spawn_info["time_start"] and time <= spawn_info["time_end"]:
			if "spawn_delay_counter" not in spawn_info:
				spawn_info["spawn_delay_counter"] = 0
			
			if spawn_info["spawn_delay_counter"] < spawn_info["spawn_delay"]:
				spawn_info["spawn_delay_counter"] += 1
			else:
				spawn_info["spawn_delay_counter"] = 0
				var new_enemy_scene = spawn_info["enemy_scene"]
				var counter = 0
				while counter < spawn_info["spawn_amount"]:
					var enemy_spawn = new_enemy_scene.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1
				
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y - vpr.y / 2)
	var top_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y - vpr.y / 2)
	var bottom_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y + vpr.y / 2)
	var bottom_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y + vpr.y / 2)
	var pos_side = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)
