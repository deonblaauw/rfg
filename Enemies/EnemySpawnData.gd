# EnemySpawnData.gd
extends Resource

class_name EnemySpawnData

@export var default_spawn_5_min_game: Array[Dictionary] = [
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


@export var smooth_spawn_5_min_game: Array[Dictionary] = [
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
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 180,
		"time_end": 210,
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 210,
		"time_end": 240,
		"spawn_delay": 0,
		"spawn_amount": 25
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 240,
		"time_end": 270,
		"spawn_delay": 0,
		"spawn_amount": 6
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 240,
		"time_end": 260,
		"spawn_delay": 0,
		"spawn_amount": 4
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


@export var default_perplexity_spawn_10_min_game: Array[Dictionary] = [
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
		"enemy_scene": preload("res://Enemies/enemy_kobold_weak.tscn"),
		"time_start": 300,
		"time_end": 360,
		"spawn_delay": 0,
		"spawn_amount": 6
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_bat.tscn"),
		"time_start": 360,
		"time_end": 420,
		"spawn_delay": 0,
		"spawn_amount": 8
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 420,
		"time_end": 480,
		"spawn_delay": 1,
		"spawn_amount": 5
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 480,
		"time_end": 510,
		"spawn_delay": 2,
		"spawn_amount": 3
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 510,
		"time_end": 540,
		"spawn_delay": 0,
		"spawn_amount": 10
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_super.tscn"),
		"time_start": 600,
		"time_end": 600,
		"spawn_delay": 0,
		"spawn_amount": 1
	}
]

@export var default_gpt_spawn_10_min_game: Array[Dictionary] = [
	{
		"enemy_scene": preload("res://Enemies/enemy_bat.tscn"),
		"time_start": 0,
		"time_end": 60,
		"spawn_delay": 0,
		"spawn_amount": 3
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_weak.tscn"),
		"time_start": 30,
		"time_end": 240,
		"spawn_delay": 1,
		"spawn_amount": 5
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 90,
		"time_end": 210,
		"spawn_delay": 1,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 210,
		"time_end": 270,
		"spawn_delay": 2,
		"spawn_amount": 3
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 240,
		"time_end": 300,
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 300,
		"time_end": 330,
		"spawn_delay": 0,
		"spawn_amount": 2
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 330,
		"time_end": 360,
		"spawn_delay": 0,
		"spawn_amount": 4
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 360,
		"time_end": 420,
		"spawn_delay": 0,
		"spawn_amount": 6
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 420,
		"time_end": 450,
		"spawn_delay": 1,
		"spawn_amount": 3
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 450,
		"time_end": 480,
		"spawn_delay": 0,
		"spawn_amount": 8
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 480,
		"time_end": 510,
		"spawn_delay": 0,
		"spawn_amount": 2
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 510,
		"time_end": 540,
		"spawn_delay": 0,
		"spawn_amount": 10
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_super.tscn"),
		"time_start": 600,
		"time_end": 600,
		"spawn_delay": 0,
		"spawn_amount": 1
	}
]



@export var smoothed_gpt_spawn_10_min_game: Array[Dictionary] = [
	{
		"enemy_scene": preload("res://Enemies/enemy_bat.tscn"),
		"time_start": 0,
		"time_end": 60,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 240
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_weak.tscn"),
		"time_start": 30,
		"time_end": 240,
		"spawn_delay": 0,
		"spawn_amount": 6,
		"enemies_spawned": 1260
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 90,
		"time_end": 210,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 480
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 210,
		"time_end": 270,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 240
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 240,
		"time_end": 300,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 240
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 300,
		"time_end": 330,
		"spawn_delay": 0,
		"spawn_amount": 2,
		"enemies_spawned": 60
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 330,
		"time_end": 360,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 120
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_kobold_strong.tscn"),
		"time_start": 360,
		"time_end": 420,
		"spawn_delay": 0,
		"spawn_amount": 6,
		"enemies_spawned": 360
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 420,
		"time_end": 450,
		"spawn_delay": 0,
		"spawn_amount": 6,
		"enemies_spawned": 180
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 450,
		"time_end": 480,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 120
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_juggernaut.tscn"),
		"time_start": 480,
		"time_end": 550,
		"spawn_delay": 0,
		"spawn_amount": 4,
		"enemies_spawned": 120
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_cyclops.tscn"),
		"time_start": 510,
		"time_end": 590,
		"spawn_delay": 0,
		"spawn_amount": 8,
		"enemies_spawned": 240
	},
	{
		"enemy_scene": preload("res://Enemies/enemy_super.tscn"),
		"time_start": 600,
		"time_end": 600,
		"spawn_delay": 0,
		"spawn_amount": 1,
		"enemies_spawned": 1
	}
]
