extends Node

var levelSelected = 0
var score = 0
signal healthChanged
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
	currentHealth = maxHealth
