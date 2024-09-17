extends CanvasLayer

##Onready Function for the implemetnion of ProgressBar
@onready var progress_bar = $ProgressBar  # Reference to the ProgressBar node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Initialized the progress bar value with the current progress from GlobalVars
	progress_bar.value = GlobalVars.progress

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	$Score.text = "Score: " + str(GlobalVars.score)
	$ProgressBar.value = GlobalVars.progress  # Update the progress bar value


	
