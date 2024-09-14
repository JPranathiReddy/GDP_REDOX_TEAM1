extends HBoxContainer

@onready var HeartGuiClass= preload("res://heart_gui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setMaxHeart(max: int):
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
		
func updateHearts(currentHealth: int):
	var heart = get_children()
	
	for i in range(currentHealth):
		heart[i].update(true)
	
	
	for i in range(currentHealth, heart.size()):
		heart[i].update(false)
	
