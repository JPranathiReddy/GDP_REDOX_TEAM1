extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_easy_btn_pressed():
	Audio.button_hit()
	GlobalVars.speed=10
	if GlobalVars.levelSelected==1:
		get_tree().change_scene_to_file("res://level_1.tscn")
	elif GlobalVars.levelSelected==2:
		get_tree().change_scene_to_file("res://level_2.tscn")
	elif GlobalVars.levelSelected==3:
		get_tree().change_scene_to_file("res://level_3.tscn")


func _on_medium_btn_pressed():
	Audio.button_hit()
	GlobalVars.speed=50
	if GlobalVars.levelSelected==1:
		get_tree().change_scene_to_file("res://level_1.tscn")
	elif GlobalVars.levelSelected==2:
		get_tree().change_scene_to_file("res://level_2.tscn")
	elif GlobalVars.levelSelected==3:
		get_tree().change_scene_to_file("res://level_3.tscn")


func _on_hard_btn_pressed():
	Audio.button_hit()
	GlobalVars.speed=200
	if GlobalVars.levelSelected==1:
		get_tree().change_scene_to_file("res://level_1.tscn")
	elif GlobalVars.levelSelected==2:
		get_tree().change_scene_to_file("res://level_2.tscn")
	elif GlobalVars.levelSelected==3:
		get_tree().change_scene_to_file("res://level_3.tscn")
