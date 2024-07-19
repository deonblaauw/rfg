extends CharacterBody2D

@export var hp = 80.0
@export var movement_speed = 20.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	movement()
	animation()
	
func movement():
	var direction = global_position.direction_to(player.global_position)
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
	print("Monster hit: ", hp)
	if hp < 0:
		queue_free() # deletes this enemy
