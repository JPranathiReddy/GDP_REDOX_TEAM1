extends CharacterBody2D

const SPEED = 300.0
signal player_hit_answer
var bullet_instance = null
@export var bullet_scene: PackedScene


func _ready():
	# Instantiate the Bullet scene and add it as a child
	pass
	
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed('ui_accept') and $ShootTimer.is_stopped():
		Audio.laser_hit()
		shoot()
	move_and_slide()

func shoot():
	if $ShootTimer.is_stopped():
		$ShootTimer.start() 
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.position = $Marker2D.global_position
		get_parent().add_child(bullet_instance)
		bullet_instance.hit_answer.connect(_on_bullet_hit_answer)

func _on_shoot_timer_timeout():
	$ShootTimer.stop()
	
func _on_bullet_hit_answer():
	player_hit_answer.emit()

func get_size() -> Vector2:
	if get_child_count() > 0 and get_child(0) is Sprite2D:
		return (get_child(0) as Sprite2D).texture.get_size()
	return Vector2.ZERO
