extends CharacterBody2D

@export var maxHp = 100.0
@export var movement_speed = 100.0
@export var healHp = 0.5
@export var healRate = 1.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var heal_timer = $healTimer

var hp = 0

# Ice Spear
var iceSpear = preload("res://Player/Attack/ice_spear.tscn")
# Attack Nodes
@onready var ice_spear_timer = $Attack/iceSpearTimer
@onready var ice_spear_attack_timer = $Attack/iceSpearTimer/iceSpearAttack
# Ice Spear Attributes
var icespear_ammo = 0
var icespear_baseammo = 5 # shoots this many in one go
var icespear_attack_speed = 1.5
var icespear_level = 1

# Enemies close by (for attack)
var enemy_close = []

func _ready():
	hp = maxHp
	attack()

func attack():
	if icespear_level > 0:
		ice_spear_timer.wait_time = icespear_attack_speed
		if ice_spear_timer.is_stopped():
			ice_spear_timer.start()
		
func _physics_process(_delta):
	movement()
	setHealRate(healRate)
	animation()
	
func setHealRate(rate):
	if rate != 0:
		heal_timer.wait_time = 1.0/rate
	
	
func movement():
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * movement_speed
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
		


func _on_hurt_box_hurt(damage):
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

func get_random_target():
	# Remove null items from the enemy_close array
	remove_null_items()
	
	if enemy_close.size() > 0:
		print("enemies: ", enemy_close.size())
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP # shoots up if there's no targets

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
