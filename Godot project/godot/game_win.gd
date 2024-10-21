extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Congratulations you have won Level "+str(GlobalVars.levelSelected)
	$Label2.text = "Score: "+str(GlobalVars.score) +"/100"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	GlobalVars._reset_game()
	get_tree().change_scene_to_file("res://LvlMenu.tscn")
