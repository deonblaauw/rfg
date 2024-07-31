extends Area2D

@export var experience = 1
@export var collect_speed = 10
var sprite_green = preload("res://Assets/Textures/Items/Gems/Gem_green.png")
var sprite_blue = preload("res://Assets/Textures/Items/Gems/Gem_blue.png")
var sprite_red = preload("res://Assets/Textures/Items/Gems/Gem_red.png")

var target = null
var speed = -1 # starting speed with negatice value creates small bounce effect

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var snd_collected = $snd_collected


func _ready():
	
	if experience < 5:
		return
	elif experience < 25:
		sprite_2d.texture = sprite_blue
	else:
		sprite_2d.texture = sprite_red

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += collect_speed * delta
		
func collected():
	snd_collected.play()
	collision_shape_2d.call_deferred("set","disabled",true)
	sprite_2d.visible = false
	return experience


func _on_snd_collected_finished():
	queue_free()
