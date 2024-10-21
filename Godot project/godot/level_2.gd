extends Node2D

@onready var bullet_scene = get_node("/root/Lvl1/Player/Bullet")  # Get a reference to the "bullet" scene
@onready var answer_spawn_scene = get_node("/root/Lvl1/AnswerSpawn")  # Get a reference to the "answer_spawn" scene
var speed := 100.0  # Declare and initialize the speed variable

var paused=false
@onready var pause_menu=$Pause_menu
# Define the movement area
var movement_area := Rect2(Vector2(100, 200), Vector2(1000, 400))
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.player_hit_answer.connect($AnswerSpawn._on_player_hit_answer)
	$KillPlane.player_missed_answer.connect($AnswerSpawn._on_player_hit_answer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = $Player
	var new_position : Vector2 = player.position  # Explicitly define the type of new_position as Vector2
	
	if Input.is_action_pressed("ui_right"):
		new_position.x += speed * delta
	if Input.is_action_pressed("ui_left"):
		new_position.x -= speed * delta
	
	var sprite_size : Vector2 = player.get_size() / 2.0  # Explicitly define the type of sprite_size as Vector2
	
	new_position.x = clamp(new_position.x, movement_area.position.x + sprite_size.x, movement_area.position.x + movement_area.size.x - sprite_size.x)
	new_position.y = clamp(new_position.y, movement_area.position.y + sprite_size.y, movement_area.position.y + movement_area.size.y - sprite_size.y)
	
	player.position = new_position
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale=1
	else:
		pause_menu.show()
		Engine.time_scale=0
	paused = !paused
