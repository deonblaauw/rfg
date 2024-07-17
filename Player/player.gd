extends CharacterBody2D

@export var movement_speed = 100.0
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(_delta):
	movement()
	animation()
	
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
		
