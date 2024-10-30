extends Control

@onready var pause_menu = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ensure the menu is hidden at the start
	pause_menu.hide()

# Pause and show menu
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): 
		toggle_pause()
func toggle_pause():
	if Engine.time_scale == 1:
		Engine.time_scale = 0  
		pause_menu.show()   
	else:
		resume_game()

# Resumes the game from pause
func _on_resumebtn_pressed():
	resume_game()

# Encapsulated logic to resume game
func resume_game():
	Engine.time_scale = 1   
	pause_menu.hide()     

# Quit game and go back to main menu
func _on_quitbtn_pressed():
	GlobalVars._reset_game()
	get_tree().change_scene_to_file("res://LvlMenu.tscn")
	Engine.time_scale = 1   # Ensure time scale is reset
