extends Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var snd_explode = $snd_explode

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("explode_anim")
	snd_explode.play()



func _on_animation_player_animation_finished(_anim_name):
	queue_free()
