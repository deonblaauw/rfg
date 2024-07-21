extends CharacterBody2D

@export var hp = 80.0
@export var movement_speed = 20.0
@export var knockback_recovery = 3.5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var snd_hit = $snd_hit

var death_anim = preload("res://Enemies/explosion.tscn")

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
	queue_free() # deletes this enemy
