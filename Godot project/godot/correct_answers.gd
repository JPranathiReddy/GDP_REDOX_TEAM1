extends CharacterBody2D

@export var speed := 25
var direction := Vector2.DOWN
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Apply the movement velocity
	if GlobalVars.levelSelected==1:
		velocity = direction * speed
	elif GlobalVars.levelSelected==2:
		velocity = direction*speed*3
	elif GlobalVars.levelSelected==3:
		velocity = direction*speed*0.4
	# Move the character based on the calculated velocity
	move_and_slide()
