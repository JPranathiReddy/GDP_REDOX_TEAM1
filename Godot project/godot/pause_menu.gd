extends Control
@onready var pause_menu = $"."
@onready var exit_menu = "res://exit_conformation.tscn"
# Called when the node enters the scene tree for the first time.


func _on_resumebtn_pressed():
	#get_tree().paused=false
	pause_menu.hide()
	Engine.time_scale=1
	

func _on_quitbtn_pressed():
	
	get_tree().change_scene_to_file("res://menu.tscn")
