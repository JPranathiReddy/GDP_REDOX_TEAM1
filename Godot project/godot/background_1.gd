extends ParallaxBackground

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.y -= 100*delta
	Audio.level1_bgm()
	
