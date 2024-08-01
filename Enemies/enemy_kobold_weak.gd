extends CharacterBody2D

@export var hp = 10.0
@export var movement_speed = 20.0
@export var knockback_recovery = 3.5
@export var experience = 1
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var snd_hit = $snd_hit

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

var death_anim = preload("res://Enemies/explosion.tscn")
var exp_gem = preload("res://Objects/experience_gem.tscn")

var knockback = Vector2.ZERO

signal remove_from_array(object)

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	movement(direction)
	animation(direction)
	
func movement(direction):
	knockback = knockback.move_toward(Vector2.ZERO , knockback_recovery)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	
func animation(direction):
	
	if not velocity.is_zero_approx():
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()
	
	if direction.x > 0.1:
		animated_sprite_2d.flip_h = true
	elif direction.x <= -0.1:
		animated_sprite_2d.flip_h = false


func _on_hurt_box_hurt(damage , angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	#print("Monster hit: ", hp)
	if hp < 0:
		death()
	else:
		snd_hit.play()

func death():
	remove_from_array.emit(self) #remove from any hurtbox that's se tot hit once
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = animated_sprite_2d.scale
	enemy_death.global_position = global_position
	#enemy_death.position = position
	get_parent().call_deferred("add_child", enemy_death)

	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child",new_gem)
	queue_free() # deletes this enemy
