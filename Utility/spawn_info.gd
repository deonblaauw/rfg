extends Resource

class_name Spawn_Info

## Enemy spawn start time (in seconds)
@export var time_start:int

## Enemy spawn stops now (in seconds from start time)
@export var time_end:int
@export var enemy:Resource

## Spawns this many enemies per Spawn Delay (in seconds). If
## Spawn Delay is 0, spawns this many enemies once per second.
@export var spawn_amount:int

## Spawns enemies per unit of time delay (in seconds). 
## Spawn delay set to: 0. Spawns per second.
## Spawn delay set to: 2. Spawns every second second.
## Spawn delay set to: 5. Spawns every fith second.
@export var spawn_delay:int

var spawn_delay_counter = 0
