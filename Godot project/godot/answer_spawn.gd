extends Node2D
# This will hold the data fetched from the server

@export var Answers: PackedScene

var http_request: HTTPRequest
var http_request_score:HTTPRequest
var questions_data = []
var questionSet
var count = 0
var correct_answers_scene = preload("res://correct_answers.tscn")
var incorrect_answers_scene = preload("res://incorrect_answers.tscn")
var correct_answers_sceneLevel3 = preload("res://CorrectAnswersLevel3.tscn")
var incorrect_answers_sceneLevel3 = preload("res://IncorrectAnswersLevel3.tscn")
var last_spawned_question = null

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	http_request_score = HTTPRequest.new()
	add_child(http_request)
	add_child(http_request_score)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request_score.connect("request_completed",Callable(self,"on_request_completed_score"))
func fetch_questions():
	var url = ""
	if GlobalVars.levelSelected == 1:
		$QuestionLabel.text = "Assign oxidation numbers to each atom in the following compounds and ions. "
		#url = "http://localhost:3000/level1questions" 
		url = "https://redoxui.onrender.com/level1questions" # Replace with your actual URL for level 1 questions
	elif GlobalVars.levelSelected == 2:
		url = "https://redoxui.onrender.com/level1questions"
		$QuestionLabel.text = "Assign oxidation numbers to each atom in the following compounds and ions."  # Replace with your actual URL for level 2 questions
	elif GlobalVars.levelSelected == 3:
		url = "https://redoxui.onrender.com/level3questions"
	var err = http_request.request(url) 
	if err != OK:
		print("Error while requesting data: ", err)
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200: 
		var body_string = body.get_string_from_utf8()
		var json_parser = JSON.new()
		var parse_result = json_parser.parse_string(body_string)
		questions_data = parse_result 

		if typeof(questions_data) == TYPE_ARRAY or typeof(questions_data) == TYPE_DICTIONARY:
			if questions_data.size() > 0:
				process_fetched_questions()
			else:
				print("No questions found.")
		else:
			print("Parsed result is not an array or dictionary.")

	else:
		print("Failed to fetch data. Status Code: ", response_code)
func process_fetched_questions():
	questions_data.shuffle()
	questionSet = questions_data
	updateLvl1QuestionsAnswers()
func update_score_in_db(level: String, new_score: int,callback: Callable):
	var url = "https://redoxui.onrender.com/update_score"
	var data = {
		"email": GlobalVars.userEmail,  
		"score": new_score,
		"level": level
	}
	var json_data = JSON.stringify(data)
	print(json_data)
	var headersDB = ["Content-Type: application/json"]
	var err = http_request_score.request(url, headersDB, HTTPClient.METHOD_POST, json_data)
	if err != OK:
		print("Error while requesting score update: ", err)
	else:
		http_request_score.connect("request_completed", callback)

func _on_score_update_complete(result, response_code, headers, body):
	if GlobalVars.levelSelected == 1:
		if GlobalVars.level1score >= 70:
			get_tree().change_scene_to_file("res://game_win.tscn")
		else:
			get_tree().change_scene_to_file("res://game_over.tscn")
	elif GlobalVars.levelSelected == 2:
		if GlobalVars.level2score >= 70:
			get_tree().change_scene_to_file("res://game_win2.tscn")
		else:
			get_tree().change_scene_to_file("res://game_over2.tscn")
	elif GlobalVars.levelSelected == 3:
		if GlobalVars.level3score >= 70:
			get_tree().change_scene_to_file("res://game_win3.tscn")
		else:
			get_tree().change_scene_to_file("res://game_over3.tscn")

# Function to update and display the current question and answers
func updateLvl1QuestionsAnswers():
	if GlobalVars.currentHealth<=0:
		if GlobalVars.levelSelected == 1:
			if GlobalVars.score>GlobalVars.level1score:
				GlobalVars.level1score = GlobalVars.score
			update_score_in_db("level1score", GlobalVars.level1score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 2:
			if GlobalVars.score>GlobalVars.level2score:
				GlobalVars.level2score = GlobalVars.score
			update_score_in_db("level2score", GlobalVars.level2score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 3:
			if GlobalVars.score>GlobalVars.level3score:
				GlobalVars.level3score = GlobalVars.score
			update_score_in_db("level3score", GlobalVars.level3score, Callable(self, "_on_score_update_complete"))
		return;
	get_tree().call_group("correct", "queue_free")
	get_tree().call_group("incorrect", "queue_free")
	if count == len(questionSet) or count >= 10:
		if GlobalVars.levelSelected == 1:
			if GlobalVars.score>GlobalVars.level1score:
				GlobalVars.level1score = GlobalVars.score
			update_score_in_db("level1score", GlobalVars.level1score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 2:
			if GlobalVars.score>GlobalVars.level2score:
				GlobalVars.level2score = GlobalVars.score
			update_score_in_db("level2score", GlobalVars.level2score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 3:
			if GlobalVars.score>GlobalVars.level3score:
				GlobalVars.level3score = GlobalVars.score
			update_score_in_db("level3score", GlobalVars.level3score, Callable(self, "_on_score_update_complete"))
		return;
	# Fetch the current question and answers
	var current_question = questionSet[count] 
	count=count+1                # Fetch the question at index (count - 1)
	if GlobalVars.levelSelected == 3:
		$QuestionLabel.text = current_question["question_text"]
	else:
		$CompoundLabel.text = current_question["question_text"]
	$QuestionNum.text = "Q.No: "+str(count)+"/10"
	var correctAnswer: Node2D
	var incorrectAnswer1: Node2D
	var incorrectAnswer2: Node2D
	var incorrectAnswer3: Node2D
	# Update with your column names
	# Instantiate the correct and incorrect answer scenes
	if GlobalVars.levelSelected == 3:
		correctAnswer = correct_answers_sceneLevel3.instantiate()
		incorrectAnswer1 = incorrect_answers_sceneLevel3.instantiate()
		incorrectAnswer2 = incorrect_answers_sceneLevel3.instantiate()
		incorrectAnswer3 = incorrect_answers_sceneLevel3.instantiate()
	else:
		correctAnswer = correct_answers_scene.instantiate()
		incorrectAnswer1 = incorrect_answers_scene.instantiate()
		incorrectAnswer2 = incorrect_answers_scene.instantiate()
		incorrectAnswer3 = incorrect_answers_scene.instantiate()
	# Update the answer labels with the correct and incorrect answers
	correctAnswer.get_node("Label").text = current_question["correctOption"]
	incorrectAnswer1.get_node("Label").text = current_question["incorrectOption1"]
	incorrectAnswer2.get_node("Label").text = current_question["incorrectOption2"]
	incorrectAnswer3.get_node("Label").text = current_question["incorrectOption3"]
	#correctAnswer.get_node("Label").self_modulate = Color(1, 1, 0)  # Red color
	#incorrectAnswer1.get_node("Label").self_modulate = Color(1, 1, 0)  # Green color
	#incorrectAnswer2.get_node("Label").self_modulate = Color(1, 1, 0)  # Blue color
	#incorrectAnswer3.get_node("Label").self_modulate = Color(1, 1, 0)  # Yellow color
	if GlobalVars.levelSelected == 3:
		set_font_size(correctAnswer.get_node("Label"),34)
		set_font_size(incorrectAnswer1.get_node("Label"),34)
		set_font_size(incorrectAnswer2.get_node("Label"),34)
		set_font_size(incorrectAnswer3.get_node("Label"),34)
	var screen_width =1200 
	var base_y = 150 # The vertical position where the answers will be aligned
	if GlobalVars.levelSelected == 1:
		 # Width of the area where answers are to be displayed
		base_y = 100
	elif GlobalVars.levelSelected == 2:  # Width of the area where answers are to be displayed
		base_y = 150
	var num_answers = 4  # Total number of answers to display
	var answer_width = 170  # Estimated width of each answer node
	var gap_between_answers = 20
	var offset_x = 60
	var positions = [
	Vector2((screen_width - (4 * answer_width)) / 2 - offset_x, base_y),  # Position 1
	Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 1 + gap_between_answers - offset_x, base_y),  # Position 2
	Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 2 + gap_between_answers * 2 - offset_x, base_y),  # Position 3
	Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 3 + gap_between_answers * 3 - offset_x, base_y)   # Position 4
	]
	# Shuffle the positions to randomize the answer placements
	positions.shuffle()
	# Assign positions randomly to the answers
	correctAnswer.position = positions[0]
	incorrectAnswer1.position = positions[1]
	incorrectAnswer2.position = positions[2]
	incorrectAnswer3.position = positions[3]
	var children = [correctAnswer, incorrectAnswer1, incorrectAnswer2, incorrectAnswer3]
	children.shuffle()
	for child in children:
		get_parent().add_child(child) 
		await get_tree().create_timer(0.5).timeout  # Wait for 1 second between spawns
func _on_start_button_pressed():
	print(GlobalVars.userEmail,"is playing")
	Audio.button_hit()
	$StartButton.hide()
	fetch_questions()

func _on_player_hit_answer():
	updateLvl1QuestionsAnswers()

func set_font_size(label_node,font_size ):
	var current_font = label_node.get("custom_fonts/font")
	if current_font:
		current_font.size = font_size
	else:
		var font_file := FontFile.new()
		#font_file.font_path = "res://Xolonium-Regular.ttf"  # Load your desired font file
		label_node.add_theme_font_override("font", font_file)
		label_node.add_theme_font_size_override("font_size", font_size)
