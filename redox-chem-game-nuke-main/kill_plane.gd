extends Area2D
signal player_missed_answer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("correct"):
		#CODE FOR DEALING WITH USER MISSING CORRECT ANSWER
		
		player_missed_answer.emit()
	else:
		#CODE FOR DEALING WITH USER NOT SHOOTING INCORRECT ANSWER
		pass
