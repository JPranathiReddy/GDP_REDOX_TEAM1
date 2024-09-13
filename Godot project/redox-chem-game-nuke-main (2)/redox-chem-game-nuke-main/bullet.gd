extends Area2D

var speed = 500.0
var direction = Vector2.UP
signal hit_answer

#@onready var correct_sound = $CorrectSound
#@onready var incorrect_sound = $IncorrectSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body):
	if body.is_in_group("correct"):
		print("hit correct answer") # Placeholder
		Audio.correct_hit()# Play the correct sound
		GlobalVars.score += 10
	else:
		print("Incorrect answer hit") # Placeholder
		Audio.incorrect_hit() # Play the incorrect sound
	hit_answer.emit()
	queue_free()
