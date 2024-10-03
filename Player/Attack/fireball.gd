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

## Fireball-specific
var return_speed = 0
var paths = 1.0 # amount of attacks javelin does while in attack mode
var attack_speed = 4.0

var target = Vector2.ZERO
var target_array = []

var angle = Vector2.ZERO

@onready var collision_shape_2d = $CollisionShape2D
@onready var attack_timer = $AttackTimer
@onready var change_direction_timer = $ChangeDirectionTimer
@onready var snd_attack = $snd_attack
@onready var animated_sprite_2d = $AnimatedSprite2D

signal remove_from_array(object)

func _ready():
	update_fireball()
	
func update_fireball():
	level = player.javelin_level
	# here we can level up our weapon stats
	match level:
		1:
			hp = 9999
			base_speed = 200.0
			damage = 2
			knockback_amount = 100
			paths = 8
			attack_size = 1.0 * (1 + player.spell_size)
			attack_speed = 5.0 * (1-player.spell_cooldown)
		2:
			hp = 9999
			base_speed = 200.0
			damage = 2
			knockback_amount = 100
			paths = 9
			attack_size = 1.0 * (1 + player.spell_size)
			attack_speed = 5.0 * (1-player.spell_cooldown)
		3:
			hp = 9999
			base_speed = 200.0
			damage = 2
			knockback_amount = 100
			paths = 10
			attack_size = 1.0 * (1 + player.spell_size)
			attack_speed = 5.0 * (1-player.spell_cooldown)
		4:
			hp = 9999
			base_speed = 200.0
			damage = 7
			knockback_amount = 120
			paths = 11
			attack_size = 1.0 * (1 + player.spell_size)
			attack_speed = 5.0 * (1-player.spell_cooldown)
	
	scale = Vector2(1.0,1.0) * attack_size
	attack_timer.wait_time = attack_speed
	
	# Javelin speeds up with player
	if player.has_method("get_movement_speed"):
		speed = player.get_movement_speed() + base_speed


func _physics_process(delta):
	if target_array.size() > 0:
		# Move towards target in attack mode
		position += angle * speed * delta
	else:
		# Calculate direction and distance to the player's reset position
		var direction_to_player = global_position.direction_to(player.global_position)
		var distance_to_player = global_position.distance_to(player.global_position)

		# Define parameters for smooth movement
		var deadband_radius = 50.0
		var min_return_speed = 10.0
		var max_return_speed = 300.0
		var speed_smoothing = 5.0

		# Determine desired speed based on distance
		var desired_speed = min_return_speed
		if distance_to_player > deadband_radius:
			desired_speed = speed + (distance_to_player - deadband_radius) * 0.1
			desired_speed = min(desired_speed, max_return_speed)

		# Smoothly adjust speed towards desired speed
		return_speed = lerpf(return_speed, desired_speed, delta * speed_smoothing)

		# Update position
		var movement = direction_to_player * return_speed * delta
		position += movement

		# Update rotation to face player
		rotation = direction_to_player.angle() + deg_to_rad(135)


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
		animated_sprite_2d.play("shooting")
	else:
		collision_shape_2d.call_deferred("set","disabled", true)
		animated_sprite_2d.play("idle")

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
