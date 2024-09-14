extends ParallaxBackground
@onready var heartContainer = $CanvasLayer/heartsContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	heartContainer.setMaxHeart(GlobalVars.maxHealth)
	heartContainer.updateHearts(GlobalVars.currentHealth)
	GlobalVars.healthChanged.connect(heartContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.y -= 100*delta
	Audio.level1_bgm()
