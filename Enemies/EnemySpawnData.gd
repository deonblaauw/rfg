# EnemySpawnData.gd
extends Resource

class_name EnemySpawnData

@export var spawn_data: Array[Dictionary] = [
	{
		"enemy_scene": preload("res://Enemies/enemy_bat.tscn"),
		"time_start": 0,
		"time_end": 50,
		"spawn_delay": 0,
		"spawn_amount": 2
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_weak.tscn"),
		"time_start": 30,
		"time_end": 210,
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 60,
		"time_end": 180,
		"spawn_delay": 1,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 180,
		"time_end": 210,
		"spawn_delay": 2,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 210,
		"time_end": 240,
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 240,
		"time_end": 270,
		"spawn_delay": 0,
		"spawn_amount": 2
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 240,
		"time_end": 240,
		"spawn_delay": 0,
		"spawn_amount": 2
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 270,
		"time_end": 300,
		"spawn_delay": 0,
		"spawn_amount": 10
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_super.tscn"),
		"time_start": 300,
		"time_end": 300,
		"spawn_delay": 0,
		"spawn_amount": 1
	}
]
