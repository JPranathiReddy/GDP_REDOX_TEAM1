extends Control

# Tracks pause status
var isPaused = false

@onready var pause_menu = $"."  # Root of the pause menu UI
@onready var pause_resume_button = $pauseresumebutton  # Pause/Resume button


# Toggle pause/resume when the pause/resume button is pressed
func _on_pauseresumebutton_pressed():
	Audio.button_hit()
	if isPaused:
		resume_game()
	else:
		pause_game()
		

# Pauses the game
func pause_game():
	isPaused = true
	Engine.time_scale = 0  # Set time scale to 0 to freeze gameplay elements

# Resumes the game
func resume_game():
	isPaused = false
	Engine.time_scale = 1  # Reset time scale to normal
