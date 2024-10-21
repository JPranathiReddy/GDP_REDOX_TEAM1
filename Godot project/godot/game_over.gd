extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$DeathSprite.play()
	$ScoreLabel.text = "Score: " + str(GlobalVars.score) + " / 100"
	GlobalVars.score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_button_pressed():
	GlobalVars._reset_game()
	get_tree().change_scene_to_file("res://LvlMenu.tscn")
