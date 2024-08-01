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
	_on_reset_position_timer_timeout()
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
			
			paths = 5
			attack_speed = 4.0
	
	scale = Vector2(1.0,1.0) * attack_size
	attack_timer.wait_time = attack_speed
	
	# Javelin speeds up with player
	if player.has_method("get_movement_speed"):
		speed = player.get_movement_speed() + base_speed
	

func _physics_process(delta):
	if target_array.size() > 0:
		position += angle * speed * delta	
	else:
		var player_angle = global_position.direction_to(reset_position)
		var distance_diff = global_position - player.global_position
		var return_speed = 20
		if abs(distance_diff.x) > 500 or abs(distance_diff.y) > 500:
			return_speed = 100
		
		position += player_angle * return_speed * delta
		rotation = global_position.direction_to(player.global_position).angle() + deg_to_rad(135)
		
# javelin doesn't take damage by hitting enemies
func enemy_hit(_charge = 1):
	pass

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
	
	var tween = create_tween()
	var new_rotation_degrees = angle.angle() + deg_to_rad(135)
	tween.tween_property(self,"rotation",new_rotation_degrees,0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

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


func _on_reset_position_timer_timeout():
	var choose_direction = randi() % 4
	reset_position = player.global_position
	
	match choose_direction:
		0:
			reset_position.x += 50.0
		1:
			reset_position.x -= 50.0
		2:
			reset_position.y += 50.0
		3:
			reset_position.y -= 50.0