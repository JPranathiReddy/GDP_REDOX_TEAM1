extends CanvasLayer
var selected_option = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_button_pressed():
	if selected_option != -1:
		Audio.button_hit()
		get_tree().change_scene_to_file(get_scene_path(selected_option))
	else:
		print("No option selected")

func _on_instructions_button_pressed():
	Audio.button_hit()
	$InstructionsMessage.show()
	$CloseButton.show()
	#$StageOptions.hide()
	$StartGameButton.hide()
	$InstructionsButton.hide()
	$Selectlevel.hide()
	#$StageOptions.hide()
	
func _on_stage_options_item_selected(index):
	Audio.button_hit()
	selected_option = index

func get_scene_path(index):
	match index:
		0:
			GlobalVars.levelSelected = 1
			return "res://level_1.tscn"
		1:
			GlobalVars.levelSelected = 2
			return "res://level_2.tscn"
		2:
			GlobalVars.levelSelected = 3
			return "res://level_3.tscn"
	return ""


func _on_close_button_pressed():
	Audio.button_hit()
	$InstructionsButton.show()
	$StartGameButton.show()
	#$StageOptions.show()
	$CloseButton.hide()
	$InstructionsMessage.hide()
	$Selectlevel.show()
