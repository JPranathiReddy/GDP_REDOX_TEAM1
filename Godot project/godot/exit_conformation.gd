extends Control

@onready var exit_con_menu=$"."


func _on_yesbtn_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_nobtn_pressed():
	exit_con_menu.hide()
	Engine.time_scale=1
