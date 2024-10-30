extends Control
var http : HTTPRequest
func _ready():
	unlock_levels_based_on_score() 
	
func fetch_user_progress(email: String):
		print(email)
		var url = "https://redoxui.onrender.com/get_user_progress/" + email
		print(url)
		var err = http.request(url)
		if err != OK:
			print("Error while requesting data: ", err)
		
func _on_progress_fetched(result, response_code, headers, body):
	var json_parser = JSON.new()
	var body_string = body.get_string_from_utf8()
	if response_code == 200:
	
		var progress = json_parser.parse_string(body_string)
		GlobalVars.level1score = progress["Level1Score"]
		GlobalVars.level2score = progress["Level2Score"]
		GlobalVars.level3score = progress["Level3Score"]
			

	else:
		print(result)
		print(body_string)
		print("Failed to fetch user progress. Status Code: ", response_code)
func unlock_levels_based_on_score():
	print("Level 1 score: ", GlobalVars.level1score)
	# Unlock levels based on score
	if GlobalVars.level1score >= 70:
		$TextureRect/Button2.disabled = false
		GlobalVars.isLevel1Completed = 1
		$TextureRect/Button2.add_theme_color_override("font_color", Color(0, 1, 0))  # Green for unlocked
		var texture_button2 = $TextureRect/Button2/HBoxContainer/TextureRect
		texture_button2.texture = load("res://unlocked.png")
	else:
		$TextureRect/Button2.disabled = true

	if GlobalVars.level2score >= 70:
		$TextureRect/Button3.disabled = false
		GlobalVars.isLevel2Completed = 1
		$TextureRect/Button3.add_theme_color_override("font_color", Color(0, 1, 0))  # Green for unlocked
		var texture_button3 = $TextureRect/Button3/HBoxContainer/TextureRect
		texture_button3.texture = load("res://unlocked.png")
	else:
		$TextureRect/Button3.disabled = true

	if GlobalVars.level3score >= 70:
		$TextureRect/Button4.disabled = false
		GlobalVars.isLevel3Completed = 1
		$TextureRect/Button4.add_theme_color_override("font_color", Color(0, 1, 0))  # Green for unlocked
		var texture_button4 = $TextureRect/Button4/HBoxContainer/TextureRect
		texture_button4.texture = load("res://unlocked.png")
	else:
		$TextureRect/Button4.disabled = true

func _on_button_1_pressed():
	Audio.button_hit()
	GlobalVars.levelSelected = 1
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_button_2_pressed():
	Audio.button_hit()
	GlobalVars.levelSelected = 2
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_button_3_pressed():
	Audio.button_hit()
	GlobalVars.levelSelected = 3
	get_tree().change_scene_to_file("res://level_3.tscn")
func _on_button_4_pressed():
	Audio.button_hit()
	GlobalVars.levelSelected = 4
	get_tree().change_scene_to_file("res://level_4.tscn")
	
func _on_texture_button_pressed():
	Audio.button_hit()
	get_tree().change_scene_to_file("res://Auth.tscn") # Replace with function body.
	
	


func _on_texture_button_2_pressed():
	Audio.button_hit()
	$TextureRect/InstructionsMessage.show()
	$TextureRect/CloseButton.show()
	$TextureRect/Button.hide()
	$TextureRect/Button2.hide()
	$TextureRect/Button3.hide()
	$TextureRect/Button4.hide()
	$TextureRect/TextureButton.hide()
	$TextureRect/TextureButton2.hide()
	$TextureRect/InstructionLabel.text = ""
	$TextureRect/backLabel.text = ""


func _on_close_button_pressed():
	Audio.button_hit()
	$TextureRect/Button.show()
	$TextureRect/Button2.show()
	$TextureRect/Button3.show()
	$TextureRect/Button4.show()
	$TextureRect/TextureButton.show()
	$TextureRect/TextureButton2.show()
	$TextureRect/InstructionsMessage.hide()
	$TextureRect/CloseButton.hide()
	$TextureRect/InstructionLabel.text = "Instructions"
	$TextureRect/backLabel.text = "Back"
	
