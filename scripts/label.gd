extends Label

@onready var label = $"."
@onready var player = $".."

@export var score_time : float
@onready var timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	PlayerVariables.jumped_through()
	
func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func _process(delta):
	label.text = "Time: " + _format_seconds(timer.time_left, true) + " Score: " +str(PlayerVariables.get_score())
