extends Area2D

## General Attack Settings
var level = 1
var hp = 9999 # javelin doesn't de-spawn
@export var base_speed = 200.0 
@export var damage = 10
@export var knockback_amount = 100
var attack_size = 1.0
## Needed for all attacks
@onready var player = get_tree().get_first_node_in_group("player")
var speed = 0

## Javelin-specific
var paths = 1.0 # amount of attacks javelin does while in attack mode
var attack_speed = 4.0

var target = Vector2.ZERO
var target_array = []

var angle = Vector2.ZERO
var reset_position = Vector2.ZERO

var sprite_jav_regular = preload("res://Assets/Textures/Items/Weapons/javelin_3_new.png")
var sprite_jav_attack = preload("res://Assets/Textures/Items/Weapons/javelin_3_new_attack.png")

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var attack_timer = $AttackTimer
@onready var change_direction_timer = $ChangeDirectionTimer
@onready var reset_position_timer = $ResetPositionTimer
@onready var snd_attack = $snd_attack

signal remove_from_array(object)

func _ready():
	update_javelin()
	
func update_javelin():
	level = player.javelin_level
	# here we can level up our weapon stats
	match level:
		1:
			hp = 9999
			base_speed = 200.0
			damage = 10
			knockback_amount = 100
			attack_size = 1.0
			
			paths = 1
			attack_speed = 4.0
	
	scale = Vector2(1.0,1.0) * attack_size
	attack_timer.wait_time = attack_speed
	
	# Javelin speeds up with player
	if player.has_method("get_movement_speed"):
		speed = player.get_movement_speed() + base_speed
	

func _physics_process(delta):
	if target_array.size() > 0:
		position += angle * speed * delta	
		
## this function despawns the ice spear after hiting an enemy
#func enemy_hit(charge = 1):
	#hp -= charge
	#if hp <= 0:
		#remove_from_array.emit(self)
		#queue_free()


func add_paths():
	snd_attack.play()
	remove_from_array.emit(self)
	target_array.clear()
	
	var counter = 0
	
	while counter < paths:
		var new_path = player.get_random_target()
		target_array.append(new_path)
		counter += 1
		enable_attack(true)
		
	target = target_array[0]
	process_path()

func process_path():
	angle = global_position.direction_to(target)
	change_direction_timer.start()

func enable_attack(attack = true):
	if attack:
		collision_shape_2d.call_deferred("set","disabled", false)
		sprite_2d.texture = sprite_jav_attack
	else:
		collision_shape_2d.call_deferred("set","disabled", true)
		sprite_2d.texture = sprite_jav_regular

func _on_attack_timer_timeout():
	add_paths()


func _on_change_direction_timer_timeout():
	if target_array.size() > 0:
		target_array.remove_at(0) # remove the old target
		if target_array.size() > 0: # see if there's a target left
			target = target_array[0] # set new target
			process_path()
			snd_attack.play()
			remove_from_array.emit(self)
		else:
			enable_attack(false)
	else:
		change_direction_timer.stop()
		attack_timer.start()
		enable_attack(false)
