extends Node

var levelSelected = 0
var score = 0
var progress = 0.0
var isLevel1Completed = 0
var isLevel2Completed = 0
var isLevel3Completed = 0
var isLevel4Completed = 0
var level1score = 0
var level2score = 0
var level3score = 0 
var answered = 0  # Variable to store the progress as a percentage (0 to 100)
signal healthChanged
var userEmail = ""
@export var maxHealth: int = 3 
@onready var currentHealth: int = maxHealth 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#reset fuctuon ro reset game
func _reset_game():
	score = 0
	levelSelected=0
	progress=0
	currentHealth = maxHealth

