extends Area2D

var level = 1
var hp = 1
@export var base_speed = 20 # this adds onto player speed for total speed
@export var damage = 5
@export var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 0

signal remove_from_array(object)

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	
	# here we can level up our weapon stats
	match level:
		1:
			hp = 1
			base_speed = 20 # above player speed
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
	
	if player.has_method("get_movement_speed"):
		speed = player.get_movement_speed() + base_speed
				
	# tween : make spear grow larger in size over time
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(tween.TRANS_QUINT).set_ease(tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	position += angle * speed * delta
	
# this function despawns the ice spear after hiting an enemy
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		remove_from_array.emit(self)
		queue_free()

# despawns ice spear if it doesn't hit anything (so it doesn't exist forever)
func _on_auto_despawn_timeout():
	remove_from_array.emit(self)
	queue_free()
