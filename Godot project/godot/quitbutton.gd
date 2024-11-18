extends Node

# Quit game and go back to the main menu
func _on_quitbtn_pressed():
	GlobalVars._reset_game()
	get_tree().change_scene_to_file("res://LvlMenu.tscn")
	Engine.time_scale = 1  # Ensure time scale is reset when quitting
	Audio.button_hit()
