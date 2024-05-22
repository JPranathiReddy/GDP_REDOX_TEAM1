extends Node2D


func correct_hit():
	$Correct.play()
func incorrect_hit():
	$Incorrect.play()
func laser_hit():
	$LaserSound.play()
func button_hit():
	$ButtonClick.play()
func level1_bgm():
	$Level1Bgm.play()
