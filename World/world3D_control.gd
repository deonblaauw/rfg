extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_music = preload("res://Assets/Audio/Music/battleThemeA.mp3")
	MusicPlayer.play_music(new_music)
	MusicPlayer.set_volume(0.1)  # Set volume to 30%
