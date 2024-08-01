extends CharacterBody2D

@export var maxHp = 100.0
@export var movement_speed = 100.0
@export var healHp = 0.5
@export var healRate = 1.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var heal_timer = $healTimer

var hp = 0

# ***************       Player Levels        ****************
var experience = 0
var experience_level = 1
var collected_experience = 0

# ***************       Player Weapons       ****************

# -----------------------------------------------------------
## Ice Spear
# -----------------------------------------------------------
var iceSpear = preload("res://Player/Attack/ice_spear.tscn")
# Attack Nodes
@onready var ice_spear_timer = $Attack/iceSpearTimer
@onready var ice_spear_attack_timer = $Attack/iceSpearTimer/iceSpearAttack

# Ice Spear Attributes
var icespear_ammo = 0
@export var icespear_baseammo = 1 # shoots this many in one go
@export var icespear_attack_speed = 1.5
var icespear_level = 1
# -----------------------------------------------------------

# -----------------------------------------------------------
## Tornado
# -----------------------------------------------------------
var tornado = preload("res://Player/Attack/tornado.tscn")
# Attack Nodes
@onready var tornado_timer = $Attack/TornadoTimer
@onready var tornado_attack_timer = $Attack/TornadoTimer/TornadoAttackTimer

# TornadoAttributes
var tornado_ammo = 0
@export var tornado_baseammo = 1 # shoots this many in one go
@export var tornado_attack_speed = 3.0
var tornado_level = 1
# -----------------------------------------------------------

# -----------------------------------------------------------
## Javelin
# -----------------------------------------------------------
var javelin = preload("res://Player/Attack/javelin.tscn")
# Attack Nodes
@onready var javelin_base = $Attack/JavelinBase

# JavelinAttributes
@export var javelin_ammo = 1
var javelin_level = 1
# -----------------------------------------------------------


# Enemies close by (for attack)
var enemy_close = []

# Last known direction
var last_direction = Vector2.UP

# GUI
@onready var experience_bar = $GUILayer/Control/ExperienceBar
@onready var lbl_level = $GUILayer/Control/ExperienceBar/lbl_level



func _ready():
	hp = maxHp
	attack()
	set_exp_bar(experience , calculate_experience_cap())

func attack():
	if icespear_level > 0:
		ice_spear_timer.wait_time = icespear_attack_speed
		if ice_spear_timer.is_stopped():
			ice_spear_timer.start()
			
	if tornado_level > 0:
		tornado_timer.wait_time = tornado_attack_speed
		if tornado_timer.is_stopped():
			tornado_timer.start()
			
	if javelin_level > 0:
		spawn_javelin()
		
func _physics_process(_delta):
	movement()
	setHealRate(healRate)
	animation()
	
func setHealRate(rate):
	if rate != 0:
		heal_timer.wait_time = 1.0/rate
	
func movement():
	var direction = Input.get_vector("left","right","up","down")
	if not direction.is_zero_approx():
		last_direction = direction
	velocity = direction.normalized() * movement_speed
	move_and_slide()
	
func animation():
	if not velocity.is_zero_approx():
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false
		

# using underscore just means we're not using that variable
func _on_hurt_box_hurt(damage , _angle, _knockback):
	hp -= damage
	print("HP:",hp)

func _on_heal_timer_timeout():
	hp += healHp
	hp = clamp(hp , 0 , maxHp)
	#print("heal:",hp)

# this timer loads the ammo
func _on_ice_spear_timer_timeout():
	icespear_ammo += icespear_baseammo
	ice_spear_attack_timer.start()

# this timer fires the loaded ammo
func _on_ice_spear_attack_timeout():
	if icespear_ammo > 0:
		var icespear_attack = iceSpear.instantiate()
		icespear_attack.position = position
		icespear_attack.target = get_random_target()
		icespear_attack.level = icespear_level
		add_child(icespear_attack)
		icespear_ammo -= 1
		if icespear_ammo > 0:
			ice_spear_attack_timer.start()
		else:
			ice_spear_attack_timer.stop()

func _on_tornado_timer_timeout():
	tornado_ammo += tornado_baseammo
	tornado_attack_timer.start()


func _on_tornado_attack_timer_timeout():
	if tornado_ammo > 0:
		var tornado_attack = tornado.instantiate()
		tornado_attack.position = position
		tornado_attack.last_movement = last_direction
		tornado_attack.level = tornado_level
		add_child(tornado_attack)
		tornado_ammo -= 1
		if tornado_ammo > 0:
			tornado_attack_timer.start()
		else:
			tornado_attack_timer.stop()
	
func get_random_target():
	# Remove null items from the enemy_close array
	remove_null_items()
	
	if enemy_close.size() > 0:
		#print("enemies: ", enemy_close.size())
		return enemy_close.pick_random().global_position
	else:
		
		# Use the last known direction when there are no enemies and player is not moving
		if last_direction.x < 0: # facing left
			return position + Vector2(-10, 0)
		elif last_direction.x > 0: # facing right
			return position + Vector2(10, 0)
		elif last_direction.y < 0: # facing up
			return position + Vector2(0, -10)
		elif last_direction.y > 0: # facing down
			return position + Vector2(0, 10)
		else:
			# Default to shooting upwards if no direction is found
			return position + Vector2(0, -10)

func remove_null_items():
	for i in range(enemy_close.size() - 1, -1, -1):
		if enemy_close[i] == null:
			enemy_close.remove_at(i)

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if not enemy_close.has(body):
		enemy_close.erase(body)

func get_movement_speed():
	return movement_speed

func spawn_javelin():
	var get_javelin_total = javelin_base.get_child_count()
	var calc_spawns = javelin_ammo - get_javelin_total
	while calc_spawns > 0:
		var javelin_spawn = javelin.instantiate()
		javelin_spawn.global_position = global_position
		javelin_base.add_child(javelin_spawn)
		calc_spawns -= 1

func calculate_experience(gem_exp):
	var exp_required = calculate_experience_cap()
	collected_experience += gem_exp
	
	#leveling up below
	if experience + collected_experience >= exp_required: 
		collected_experience -= exp_required - experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experience_cap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
		
	set_exp_bar(experience , exp_required)

func levelup():
	#print("Level: ", experience_level)
	lbl_level.text = str("Level: ", experience_level)
	calculate_experience(0)
	
func calculate_experience_cap():
	var exp_cap = experience_level
	
	if experience_level < 20:
		exp_cap = experience_level * 5.0
	elif experience_level < 40:
		exp_cap = 95 + (experience_level - 19) * 8
	else:
		exp_cap = 255 + (experience_level - 39) * 12
		
	return exp_cap
	
func set_exp_bar(set_value = 1, set_max_value = 100):
	experience_bar.value = set_value
	experience_bar.max_value = set_max_value

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collected()
		calculate_experience(gem_exp)
