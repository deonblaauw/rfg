extends CharacterBody2D

@export var maxHp = 100.0
@export var movement_speed = 100.0
@export var healHp = 0.5
@export var healRate = 1.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var heal_timer = $healTimer

var hp = 0

func _on_ready():
	hp = maxHp

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



