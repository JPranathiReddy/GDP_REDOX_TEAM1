extends Node2D

@export var Answers: PackedScene

var http_request_level4: HTTPRequest
var http_request_level5: HTTPRequest
var questions_data_level4 = []
var questions_data_level5 = []
var questionSet = []  # Final combined question set of 10 questions (6 from level 4 and 4 from level 5)
var count = 0
var correct_answers_scene_level5 = preload("res://CorrectAnswersLevel3.tscn")
var incorrect_answers_scene_level5 = preload("res://IncorrectAnswersLevel3.tscn")
var correct_answers_scene_level4 = preload("res://correct_answers.tscn")
var incorrect_answers_scene_level4 = preload("res://incorrect_answers.tscn")
var last_spawned_question = null

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request_level4 = HTTPRequest.new()
	http_request_level5 = HTTPRequest.new()
	add_child(http_request_level4)
	add_child(http_request_level5)
	
	# Connect both HTTP requests to a single generic handler
	http_request_level4.connect("request_completed", Callable(self, "_on_request_completed").bind("level4"))
	http_request_level5.connect("request_completed", Callable(self, "_on_request_completed").bind("level5"))

func fetch_questions():
	var url_level4 = "https://redoxui.onrender.com/level4questions"
	var url_level5 = "https://redoxui.onrender.com/level5questions"
	
	# Request questions from both endpoints
	var err4 = http_request_level4.request(url_level4)
	var err5 = http_request_level5.request(url_level5)
	
	if err4 != OK or err5 != OK:
		print("Error while requesting data: ", err4, err5)

# Single handler for both level 4 and level 5 requests
func _on_request_completed(result, response_code, headers, body, level):
	if response_code == 200:
		var body_string = body.get_string_from_utf8()
		var json_parser = JSON.new()
		var parse_result = json_parser.parse_string(body_string)
		if typeof(parse_result) == TYPE_ARRAY:
			if level == "level4":
				questions_data_level4 = parse_result  # Store level 4 questions
			elif level == "level5":
				questions_data_level5 = parse_result  # Store level 5 questions
	else:
		print("Failed to fetch data from ", level, " Status Code: ", response_code)

	# Check if both requests are completed and data is available
	if questions_data_level4.size() > 0 and questions_data_level5.size() > 0:
		process_combined_questions()

func process_combined_questions():
	# Shuffle and select 6 random questions from level 4
	questions_data_level4.shuffle()
	var selected_level4_questions = questions_data_level4.slice(0, 6)

	# Shuffle and select 4 random questions from level 5
	questions_data_level5.shuffle()
	var selected_level5_questions = questions_data_level5.slice(0, 4)

	# Combine the selected questions into the final questionSet
	questionSet = selected_level4_questions + selected_level5_questions
	print(questionSet)
	# Proceed to display questions
	updateLvlQuestionsAnswers()

func update_score_in_db(level: String, new_score: int, callback: Callable):
	var url = "https://redoxui.onrender.com/update_score"
	var data = {
		"email": GlobalVars.userEmail,  
		"score": new_score,
		"level": level
	}
	var json_data = JSON.stringify(data)
	print(json_data)
	var headersDB = ["Content-Type: application/json"]
	var err = http_request_level4.request(url, headersDB, HTTPClient.METHOD_POST, json_data)
	if err != OK:
		print("Error while requesting score update: ", err)
		callback.call()
	else:
		http_request_level4.connect("request_completed", callback)

func _on_score_update_complete(result, response_code, headers, body):
	if GlobalVars.score >= 70:
		get_tree().change_scene_to_file("res://game_win.tscn")
	else:
		get_tree().change_scene_to_file("res://game_over.tscn")

# Function to display questions and answers
func updateLvlQuestionsAnswers():
	GlobalVars.even = 0
	if GlobalVars.currentHealth <= 0:
		update_score_in_db("level4", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		return
	
	get_tree().call_group("correct", "queue_free")
	get_tree().call_group("incorrect", "queue_free")
	
	if count == len(questionSet) or count >= 10:
		if GlobalVars.score > GlobalVars.levelCombinedScore or GlobalVars.isLevelCompleted == 0:
			GlobalVars.levelCombinedScore = GlobalVars.score
			update_score_in_db("level4", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://game_win.tscn")
		return

	var current_question = questionSet[count]
	count += 1

	# Combine question text and equation if applicable
	var full_question_text = current_question["question_text"]
	if "equation" in current_question and current_question["equation"] != "":
		full_question_text += "\n" + current_question["equation"]
	
	$QuestionLabel.text = full_question_text
	$QuestionNum.text = "Q.No: " + str(count) + "/10"

	# Create nodes for each option dynamically
	var option_labels = [current_question["correctOption"]]
	if typeof(current_question["options"]) == TYPE_STRING:
		print("Raw options string: ", current_question["options"])
	
	# Try parsing the string into a valid array
		var json_parser = JSON.new()
		var parse_result = json_parser.parse(current_question["options"])

		if parse_result == OK:
			var options_array = json_parser.get_data()  # Get the parsed array
			
			if typeof(options_array) == TYPE_ARRAY:
				for option in options_array:
					option_labels.append(option)  # Add each option individually
			else:
				print("Error: The parsed data is not an array. It is: ", typeof(options_array))
		else:
			print("Error: Failed to parse options string. JSON parse result: ", parse_result)
	elif typeof(current_question["options"]) == TYPE_ARRAY:
	# If it's already an array, just add the options
		for option in current_question["options"]:
			option_labels.append(option)
	else:
		print("Error: Options are neither a string nor an array.")
	option_labels.shuffle()
	print(option_labels)
	var positions = []
	var start_x = (1100 - (option_labels.size() * 200))/5  # Adjust for different numbers of options
	for i in range(option_labels.size()):
		if(i%2==0):
			positions.append(Vector2(start_x + i * 170, 300))
		else:
			positions.append(Vector2(start_x + i * 170, 200))
	# Create and place answer nodes
	for i in range(option_labels.size()):
		var answer_node: Node2D
		GlobalVars.even += 1
		if option_labels[i] == current_question["correctOption"]:
			
			answer_node = (correct_answers_scene_level4 if count <= 6 else correct_answers_scene_level5).instantiate()
		else:
			answer_node = (incorrect_answers_scene_level4 if count <= 6 else incorrect_answers_scene_level5).instantiate()
		answer_node.add_to_group("level4_options")
		answer_node.set("base_position", positions[i])
		answer_node.get_node("Label").text = option_labels[i]
		answer_node.position = positions[i]
		get_parent().add_child(answer_node)
		await get_tree().create_timer(0.3).timeout
	

func _on_start_button_pressed():
	print(GlobalVars.userEmail, "is playing")
	Audio.button_hit()
	$StartButton.hide()
	fetch_questions()
	

func _on_player_hit_answer():
	updateLvlQuestionsAnswers()

func set_font_size(label_node, font_size):
	var current_font = label_node.get("custom_fonts/font")
	if current_font:
		current_font.size = font_size
	else:
		var font_file := FontFile.new()
		# font_file.font_path = "res://Xolonium-Regular.ttf"  # Load your desired font file
		label_node.add_theme_font_override("font", font_file)
		label_node.add_theme_font_size_override("font_size", font_size)
