extends Area2D

var speed = 500.0
var direction = Vector2.UP
signal hit_answer
var http_request_bullet:HTTPRequest
#@onready var correct_sound = $CorrectSound
#@onready var incorrect_sound = $IncorrectSound

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.answered = 0
	http_request_bullet = HTTPRequest.new()
	add_child(http_request_bullet)  # Add HTTPRequest node to the scene
	http_request_bullet.connect("request_completed",Callable(self,"_on_request_completed_score"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body):
	GlobalVars.answered = 1
	if body.is_in_group("correct"):
		print("hit correct answer") # Placeholder
		Audio.correct_hit()# Play the correct sound
		GlobalVars.score += 10
		GlobalVars.progress+=10.0
		
		
	else:
		print("Incorrect answer hit") # Placeholder
		Audio.incorrect_hit() 
		if body.has_method("get_node"):
			var label = body.get_node("Label")  # Assuming the body has a child node called "Label"
			if label:
				label.self_modulate = Color(1, 0, 0)
				await get_tree().create_timer(0.5).timeout
				queue_free()# Play the incorrect sound
		GlobalVars.currentHealth -=1
		#if GlobalVars.currentHealth<=0:
			#update_score_in_db("level" + str(GlobalVars.levelSelected)+"score", GlobalVars.score)
			#if GlobalVars.score>=70:
				#get_tree().change_scene_to_file("res://game_win.tscn")
			#else:
				#get_tree().change_scene_to_file("res://game_over.tscn")
			#GlobalVars.currentHealth= GlobalVars.maxHealth
			#return;
		GlobalVars.healthChanged.emit(GlobalVars.currentHealth)
	
	hit_answer.emit()
	queue_free()
func update_score_in_db(level: String, new_score: int):

	var url = "https://redoxui.onrender.com/update_score"
	var data = {
		"email": GlobalVars.userEmail,  
		"score": new_score,
		"level": level
	}

	var json_data = JSON.stringify(data)
	print("Sending request data: ", json_data)

	var headers = ["Content-Type: application/json"]
	var err = http_request_bullet.request(url, headers, HTTPClient.METHOD_POST, json_data)

	if err != OK:
		print("Error sending request: ", err)
	else:
		print("Request sent successfully.")

# Handle the response from the score update request
func _on_request_completed_score(result, response_code, headers, body):
	print("Response Code: ", response_code)
	print("Response Body: ", body.get_string_from_utf8())
	if response_code == 200:
		print("Score updated successfully.")
	elif response_code == 404:
		print("User not found or score not updated.")
	else:
		print("Failed to update score. Status Code: ", response_code)

