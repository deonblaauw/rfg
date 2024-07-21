extends CharacterBody2D

@export var hp = 80.0
@export var movement_speed = 20.0
@export var knockback_recovery = 3.5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")

var knockback = Vector2.ZERO

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
		queue_free() # deletes this enemy
