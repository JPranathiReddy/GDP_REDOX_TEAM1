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
	

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	if body.is_in_group("correct"):
		print("hit correct answer")
		Audio.correct_hit()
		
		# Implementation for Score
		GlobalVars.score += 10
		
		# Implementation for progress bar
		GlobalVars.progress += 5.0
		if GlobalVars.progress > 100:
			GlobalVars.progress = 100  # Cap the progress at 100%
	else:
		print("Incorrect answer hit")
		Audio.incorrect_hit()
		
		# Decrease health if incorrect
		GlobalVars.currentHealth -= 1
		if GlobalVars.currentHealth < 0:
			GlobalVars.currentHealth = GlobalVars.maxHealth
		
		# Emit health change signal
		GlobalVars.healthChanged.emit(GlobalVars.currentHealth)

	# Emit answer hit signal
	hit_answer.emit()
	queue_free()
