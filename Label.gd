extends Label

@onready var label = $"."
@onready var timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time : float = timer.get_time_left()
	var minutes : float = floor(time / 60)
	var seconds : float = fmod(time, 60)
	if seconds >= 59:
		minutes += 1
	if ceil(seconds) == 60:
#		seconds = 0.0
		label.text = "Time: " + str(minutes) + ":00"
	else:
		label.text = "Time: " + str(minutes) + ":"+ str(roundf(seconds))
	
