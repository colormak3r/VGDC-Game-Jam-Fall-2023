extends Node

@onready var audio_stream_player = $AudioStreamPlayer

var music = load("res://audio/Ride_of_the_Valkyries_by_Wagner.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_music():
	
	$AudioStreamPlayer.stream = music
	$AudioStreamPlayer.play()
