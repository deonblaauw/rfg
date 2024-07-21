extends Area2D

var level = 1
var hp = 9999 # don't want tornado to die too soon after hitting enemy
@export var base_speed = -50 # this adds onto player speed for total speed
@export var damage = 5
@export var knockback_amount = 100
var attack_size = 1.0

var last_movement = Vector2.ZERO
var target = Vector2.ZERO
var angle = Vector2.ZERO
var angle_less = Vector2.ZERO
var angle_more = Vector2.ZERO

var spwnDistNear = 0.25
var spwnDistFar = 1.0
var spwnRangeScale = 500.0

@export var tornado_tween_time = 3.0

signal remove_from_array(object)

@onready var player = get_tree().get_first_node_in_group("player")

var speed = 0

func _ready():
	#angle = global_position.direction_to(target)
	#rotation = angle.angle() + deg_to_rad(135)
	
	# here we can level up our weapon stats
	match level:
		1:
			hp = 1
			speed = 100
			damage = 50
			knockback_amount = 100
			attack_size = 1.0
			
	var move_to_less = Vector2.ZERO
	var move_to_more = Vector2.ZERO
	
	match last_movement:
		Vector2.UP, Vector2.DOWN:
			print("Up Down: ",last_movement)
			move_to_less = global_position + Vector2(randf_range( -spwnDistFar, -spwnDistNear), last_movement.y)*spwnRangeScale
			move_to_more = global_position + Vector2(randf_range( spwnDistNear, spwnDistFar), last_movement.y)*spwnRangeScale
		Vector2.RIGHT, Vector2.LEFT:
			print("Right Left: ",last_movement)
			move_to_less = global_position + Vector2(last_movement.x , randf_range( -spwnDistFar, -spwnDistNear))*spwnRangeScale
			move_to_more = global_position + Vector2(last_movement.x, randf_range( spwnDistNear, spwnDistFar))*spwnRangeScale
		_: # diagnol case
			move_to_less = global_position + Vector2(last_movement.x , last_movement.y*randf_range(0.0,0.75))*spwnRangeScale
			move_to_more = global_position + Vector2(last_movement.x*randf_range(0.0,0.75) , last_movement.y)*spwnRangeScale
			
	angle_less = global_position.direction_to(move_to_less)
	angle_more = global_position.direction_to(move_to_more)
	
	# initial tween
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size , tornado_tween_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

	if player.has_method("get_movement_speed"):
		speed = player.get_movement_speed() + base_speed
		
	var final_speed = speed
	speed = speed / 5.0
	tween.tween_property(self,"speed", final_speed , tornado_tween_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


	# use tweens to alter the angle property
	#var tween = create_tween()
	var set_angle = randi_range(0,1)
	if set_angle == 1:
		angle = angle_less
		tween.tween_property(self,"angle",angle_more,2)
		tween.tween_property(self,"angle",angle_less,2)
		tween.tween_property(self,"angle",angle_more,2)
		tween.tween_property(self,"angle",angle_less,2)
		tween.tween_property(self,"angle",angle_more,2)
		tween.tween_property(self,"angle",angle_less,2)
	else:
		angle = angle_more
		tween.tween_property(self,"angle",angle_less,2)
		tween.tween_property(self,"angle",angle_more,2)
		tween.tween_property(self,"angle",angle_less,2)
		tween.tween_property(self,"angle",angle_more,2)
		tween.tween_property(self,"angle",angle_less,2)
		tween.tween_property(self,"angle",angle_more,2)
		
	tween.play()
	
	
func _physics_process(delta):	
	#if player.has_method("get_movement_speed"):
		#speed = player.get_movement_speed() + base_speed
		
	position += angle * speed * delta

# tornado doesn't take damage by hitting enemies, it just dies out
func enemy_hit(_charge = 1):
	pass

func _on_auto_despawn_timeout():
	remove_from_array.emit(self)
	queue_free()
