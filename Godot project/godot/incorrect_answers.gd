extends CharacterBody2D


var direction1 := Vector2.DOWN
var direction2 := Vector2.UP
var x_speed = 2 # Speed in x direction
var y_speed = 2  # Speed in y direction
var x_amplitude = 2  # Amplitude for x movement
var y_amplitude = 2  # Amplitude for y movement
var time_passed = 0
var screen_size = Vector2()
var max_y = 300
var even = 0
var offset_y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVars.levelSelected==1:
		velocity = direction1 * GlobalVars.speed
	elif GlobalVars.levelSelected==2:
		velocity = direction1 * GlobalVars.speed*1.5
	elif GlobalVars.levelSelected==3:
		velocity = direction1 * GlobalVars.speed*2

	# Move the character based on the calculated velocity
	move_and_slide()
