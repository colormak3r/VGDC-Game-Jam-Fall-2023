extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	player_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func player_music():
	audio_stream_player.play()
