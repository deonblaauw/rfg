extends Node2D

enum SpawnMode {
	Default5Min,
	Smooth5Min,
	Default10MinPerplexed,
	Default10MinGPT,
	Smoothed10MinGPT
}


@export var active_spawn_mode : SpawnMode

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

	var spawn_data = null
	
	match active_spawn_mode:
		SpawnMode.Default5Min:
			spawn_data = spawn_data_resource.default_spawn_5_min_game
		SpawnMode.Smooth5Min:
			spawn_data = spawn_data_resource.smooth_spawn_5_min_game
		SpawnMode.Default10MinPerplexed:
			spawn_data = spawn_data_resource.default_perplexity_spawn_10_min_game
		SpawnMode.Default10MinGPT:
			spawn_data = spawn_data_resource.default_gpt_spawn_10_min_game
		SpawnMode.Smoothed10MinGPT:
			spawn_data = spawn_data_resource.smoothed_gpt_spawn_10_min_game
		_:
			print("Something went wrong!")
	
	if not spawn_data:
		print("fail")
		return
	Global.current_world_end_time = spawn_data[-1]["time_end"]
	#print("xxxx")
	#print(Global.current_world_end_time)
	#print(spawn_data[-1]["time_end"])
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
