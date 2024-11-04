extends Control

# Tracks pause status and countdown time
var isPaused = false
var remaining_time = 15  # Countdown duration in seconds
var countdown_active = false  # Flag to check if countdown is running

@onready var pause_menu = $"."  # Root of the pause menu UI
@onready var resume_button = $resumebtn  # Resume button reference
@onready var countdown_label = $countdown_label  # Countdown display label

# Called to initialize pause logic
func _ready():
	countdown_label.text = ""  # Initialize countdown label as empty

# Toggle pause/resume when the resume button is pressed
func _on_resumebtn_pressed():
	if isPaused:
		resume_game()
	else:
		pause_game()

# Pauses the game and starts the countdown
func pause_game():
	isPaused = true
	remaining_time = 15  # Reset countdown
	countdown_label.text = "Resuming in: %d" % remaining_time  # Initialize countdown display
	if get_tree():
		get_tree().paused = true  # Freeze gameplay by pausing the tree
	countdown_active = true  # Set countdown flag
	_task_countdown()  # Start countdown update

# Countdown as an async function to update each second
func _task_countdown():
	while remaining_time > 0 and countdown_active:
		countdown_label.text = "Game Resumes In: %d" % remaining_time  # Update label
		await get_tree().create_timer(1).timeout  # Wait for 1 second
		remaining_time -= 1  # Reduce remaining time by 1
		# Exit countdown if manually resumed
		if not isPaused or !countdown_active:
			countdown_label.text = ""  # Clear the countdown display
			return  
	# Resume game when countdown ends
	if remaining_time <= 0 and countdown_active:
		_on_pause_timer_timeout()

# Resumes the game
func resume_game():
	isPaused = false
	countdown_active = false  # Stop countdown
	remaining_time = 15  # Reset countdown for next pause
	if get_tree():
		get_tree().paused = false  # Unfreeze gameplay by unpausing the tree
	countdown_label.text = ""  # Clear the countdown display

# Automatically resumes the game when countdown completes
func _on_pause_timer_timeout():
	if isPaused:  # Only resume if still paused when timer ends
		resume_game()

# Quit game and go back to the main menu
func _on_quitbtn_pressed():
	countdown_active = false  # Stop countdown
	GlobalVars._reset_game()
	if get_tree():
		get_tree().paused = false  # Ensure tree is unpaused when quitting
	get_tree().change_scene_to_file("res://LvlMenu.tscn")  # Switch to the main menu
