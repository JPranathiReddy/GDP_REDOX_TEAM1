extends CharacterBody2D

@export var speed := 25
var direction := Vector2.DOWN
var direction2 := Vector2.UP
var x_speed = 2 # Speed in x direction
var y_speed = 2  # Speed in y direction
var x_amplitude = 2  # Amplitude for x movement
var y_amplitude = 2  # Amplitude for y movement
var time_passed = 0
var screen_size = Vector2()
var max_y = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVars.levelSelected==1:
		velocity = direction * speed
	elif GlobalVars.levelSelected==2:
		velocity = direction*speed*3
	elif GlobalVars.levelSelected==3:
		velocity = direction*speed*0.4
	elif GlobalVars.levelSelected==4:
		velocity = direction1*speed*2
		if position.y > 200:
			time_passed += delta
			var new_x = position.x + sin(time_passed * x_speed) * x_amplitude
			var new_y = position.y + cos(time_passed * y_speed) * y_amplitude
			
			new_x = clamp(new_x, 0, screen_size.x)
			new_y = clamp(new_y, 0,screen_size.y )
			
			position= Vector2(new_x,max_y)
	# Move the character based on the calculated velocity
	move_and_slide()
