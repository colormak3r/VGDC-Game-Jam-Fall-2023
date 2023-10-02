extends Node

var player_score : float = 0
var update_score : float = 0
var through_portal : bool = false
var time_checked : bool = false
var music_progress = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_score(player_score):
	update_score += player_score

func get_score():
	return update_score

func jumped_through():
	through_portal = true

func get_jumped_through():
	return through_portal



