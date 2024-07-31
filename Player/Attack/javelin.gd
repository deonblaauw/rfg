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

## Javelin-specific
var paths = 1.0 # amount of attacks javelin does while in attack mode
var attack_speed = 4.0

var target = Vector2.ZERO
var target_array = []

var angle = Vector2.ZERO
var reset_position = Vector2.ZERO

var sprite_jav_regular = preload("res://Assets/Textures/Items/Weapons/javelin_3_new.png")
var sprite_jav_attack = preload("res://Assets/Textures/Items/Weapons/javelin_3_new_attack.png")

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var attack_timer = $AttackTimer
@onready var change_direction_timer = $ChangeDirectionTimer
@onready var reset_position_timer = $ResetPositionTimer
@onready var snd_attack = $snd_attack

signal remove_from_array(object)

func _ready():
	update_javelin()
	
func update_javelin():
	level = player.javelin_level
	# here we can level up our weapon stats
	match level:
		1:
			hp = 9999
			base_speed = 200.0
			damage = 10
			knockback_amount = 100
			attack_size = 1.0
	
# this function despawns the ice spear after hiting an enemy
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		remove_from_array.emit(self)
		queue_free()

# despawns javelin if it doesn't hit anything (so it doesn't exist forever)
func _on_auto_despawn_timeout():
	remove_from_array.emit(self)
	queue_free()

