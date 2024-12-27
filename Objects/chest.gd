extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var snd_opened: AudioStreamPlayer = $snd_opened


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("chest_close_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
