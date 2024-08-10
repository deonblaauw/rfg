extends Node

# Export variable for the audio stream
@export var music_stream : AudioStream

# Export variable for volume control, with a default value
@export var volume : float = 1.0

var audio_player : AudioStreamPlayer

func _ready():
	# Initialize AudioStreamPlayer if not already present
	if not audio_player:
		audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.stream = music_stream
		audio_player.volume_db = linear_to_db(volume)  # Set initial volume
		audio_player.play()

func play_music(stream: AudioStream):
	if audio_player:
		audio_player.stop()
		audio_player.stream = stream
		audio_player.volume_db = linear_to_db(volume)  # Set volume for new stream
		audio_player.play()

func stop_music():
	if audio_player:
		audio_player.stop()

# Setter function for volume
func set_volume(value: float) -> void:
	volume = clamp(value, 0.0, 1.0)  # Ensure volume is between 0.0 and 1.0
	if audio_player:
		audio_player.volume_db = linear_to_db(volume)  # Convert linear volume to dB
