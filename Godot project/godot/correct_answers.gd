extends CharacterBody2D

@export var speed := 20
var direction1 := Vector2.DOWN
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
	# Apply the movement velocity
	if GlobalVars.levelSelected==1:
		velocity = direction1 * GlobalVars.speed*0.8
		move_and_slide()
	elif GlobalVars.levelSelected==2:
		velocity = direction1* GlobalVars.speed*1.0
		move_and_slide()
	elif GlobalVars.levelSelected==3:
		velocity = direction1* GlobalVars.speed*0.5
		move_and_slide()
	elif GlobalVars.levelSelected==4:
		for option_node in get_tree().get_nodes_in_group("level4_options"):
			if option_node and option_node.has_method("position"):
				var base_position = option_node.get("base_position")  # Store or default to current position
				var amplitude = 50  # Horizontal swing amplitude
				var frequency = 1.0  # Speed of the swing (adjust as needed)

				# Update the x-position to oscillate back and forth
				option_node.position.x = base_position.x + amplitude * sin(Time.get_ticks_msec() / 1000.0 * frequency * PI)
	# Move the character based on the calculated velocity
