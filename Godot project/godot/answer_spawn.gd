extends Node2D
  # This will hold the data fetched from the server

@export var Answers: PackedScene

var level1 = {
	"question" = "Assign oxidation numbers to each atom in the following compounds and ions.",
	
	"1" = {
		"compound": "LiOH",
		"correct": "Li = +1, H = +1, O = -2",
		"incorrect1": "Li = -1, H = -1, O = -1",
		"incorrect2": "Li = +2, H = +2, O = +1",
		"incorrect3": "Li = -2, H = -2, O = -3"
	},
	
	"2" = {
		"compound": "NO₃⁻",
		"correct": "O = -2, N = +5",
		"incorrect1": "O = +2, N = -3",
		"incorrect2": "O = -1, N = +1",
		"incorrect3": "O = +3, N = -2"
	},
	
	"3" = {
		"compound": "SO₂",
		"correct": "O = -2, S = +4",
		"incorrect1": "O = +1, S = -1",
		"incorrect2": "O = -3, S = +3",
		"incorrect3": "O = -1, S = +2"
	},
	
	"4" = {
		"compound": "H₂O",
		"correct": "O = -2, H = +1",
		"incorrect1": "O = +2, H = -1",
		"incorrect2": "O = -2, H = +2",
		"incorrect3": "O = +1, H = -2"
	},
	
	"5" = {
		"compound": "S₂O₃²⁻",
		"correct": "O = -2, S = +1",
		"incorrect1": "O = +2, S = -1",
		"incorrect2": "O = +1, S = -2",
		"incorrect3": "O = -3, S = +1"
	}, 
	
	"6" = {
		"compound": "MnO₄⁻",
		"correct": "O = -2, Mn = +7",
		"incorrect1": "O = +4, Mn = -3",
		"incorrect2": "O = -1, Mn = +6",
		"incorrect3": "O = +2, Mn = -7"
	},
	
	"7" = {
		"compound": "CO₂",
		"correct": "O = -2, C = +4",
		"incorrect1": "O = +2, C = -4",
		"incorrect2": "O = +1, C = -2",
		"incorrect3": "O = -2, C = +3"
	},
	
	"8" = {
		"compound": "C",
		"correct": "C = 0",
		"incorrect1": "C = +1",
		"incorrect2": "C = -1",
		"incorrect3": "C = +2"
	},
	
	"9" = {
		"compound": "Fe",
		"correct": "Fe = 0",
		"incorrect1": "Fe = -1",
		"incorrect2": "Fe = +2",
		"incorrect3": "Fe = +4"
	},
	
	"10" = {
		"compound": "NO",
		"correct": "O = -2, N = +2",
		"incorrect1": "O = +2, N = -2",
		"incorrect2": "O = +1, N = -2",
		"incorrect3": "O = +2, N = -1"
	},
	
	"11" = {
		"compound": "NO₂",
		"correct": "O = -2, N = +4",
		"incorrect1": "O = +2, N = -4",
		"incorrect2": "O = +2, N = -1",
		"incorrect3": "O = -2, N = +2"
	},
	
	"12" = {
		"compound": "SCl₂",
		"correct": "Cl = -1, S = +2",
		"incorrect1": "Cl = +2, S = -1",
		"incorrect2": "Cl = +1, S = -2",
		"incorrect3": "Cl = -1, S = +4"
	},
	
	"13" = {
		"compound": "H₂S₂O₇",
		"correct": "H = +1, O = -2, S = +6",
		"incorrect1": "H = +1, O = +2, S = -6",
		"incorrect2": "H = -2, O = +1, S = +6",
		"incorrect3": "H = +6, O = -2, S = +1"
	},
	
	"14" = {
		"compound": " F⁻",
		"correct": "F = -1",
		"incorrect1": "F = +1",
		"incorrect2": "F = -2",
		"incorrect3": "F = 0"
	},
	
	"15" = {
		"compound": "H₂S",
		"correct": "H = +1, S = -2",
		"incorrect1": "H = -1, S = +2",
		"incorrect2": "H = -2, S = +1",
		"incorrect3": "H = +2, S = -1"
	},
	
	"16" = {
		"compound": "CrO₄²⁻",
		"correct": "O = -2, Cr = +6",
		"incorrect1": "O = +2, Cr = +3",
		"incorrect2": "O = -3, Cr = -2",
		"incorrect3": "O = -1, Cr = +5"
	},
	
	"17" = {
		"compound": "S₈",
		"correct": "S = 0",
		"incorrect1": "S = +4",
		"incorrect2": "S = -4",
		"incorrect3": "S = +8"
	},
	
	"18" = {
		"compound": "Cu",
		"correct": "Cu = 0",
		"incorrect1": "Cu = -1",
		"incorrect2": "Cu = +2",
		"incorrect3": "Cu = +4"
	},
	
	"19" = {
		"compound": "Zn²⁺",
		"correct": "Zn = +2",
		"incorrect1": "Zn = -2",
		"incorrect2": "Zn = +1",
		"incorrect3": "Zn = 0"
	},
	
	"20" = {
		"compound": "O₂",
		"correct": "O = 0",
		"incorrect1": "O = -1",
		"incorrect2": "O = +2",
		"incorrect3": "O = -2"
	},
	
	"21" = {
		"compound": "CrCl₂",
		"correct": "Cl = -1, Cr = +2",
		"incorrect1": "Cl = +2, Cr = -1",
		"incorrect2": "Cl = -2, Cr = +4",
		"incorrect3": "Cl = -3, Cr = +1"
	},
	
	"22" = {
		"compound": "Na₂CrO₄",
		"correct": "Na = +1, O = -2, Cr = +6",
		"incorrect1": "Na = -2, O = +4, Cr = +3",
		"incorrect2": "Na = +2, O = -1, Cr = -6",
		"incorrect3": "Na = +3, O = -3, Cr = +4"
	},
	
	"23" = {
		"compound": "K₂Cr₂O₇",
		"correct": "K = +1, O = -2, Cr = +6",
		"incorrect1": "K = -2, O = +7, Cr = +2",
		"incorrect2": "K = +2, O = -1, Cr = -6",
		"incorrect3": "K = +3, O = -3, Cr = +3"
	},
	
	"24" = {
		"compound": "F₂",
		"correct": "F = 0",
		"incorrect1": "F = -2",
		"incorrect2": "F = +1",
		"incorrect3": "F = -1"
	}
}

var level2 = {
	"question" = "Assign oxidation numbers to each atom in the following compounds and ions.",
	
	"1" = {
		"compound": "LiOH",
		"correct": "Li = +1, H = +1, O = -2",
		"incorrect1": "Li = -1, H = -1, O = -1",
		"incorrect2": "Li = +2, H = +2, O = +1",
		"incorrect3": "Li = -2, H = -2, O = -3"
	},
	
	"2" = {
		"compound": "NO₃⁻",
		"correct": "O = -2, N = +5",
		"incorrect1": "O = +2, N = -3",
		"incorrect2": "O = -1, N = +1",
		"incorrect3": "O = +3, N = -2"
	},
	
	"3" = {
		"compound": "SO₂",
		"correct": "O = -2, S = +4",
		"incorrect1": "O = +1, S = -1",
		"incorrect2": "O = -3, S = +3",
		"incorrect3": "O = -1, S = +2"
	},
	
	"4" = {
		"compound": "H₂O",
		"correct": "O = -2, H = +1",
		"incorrect1": "O = +2, H = -1",
		"incorrect2": "O = -2, H = +2",
		"incorrect3": "O = +1, H = -2"
	},
	
	"5" = {
		"compound": "S₂O₃²⁻",
		"correct": "O = -2, S = +1",
		"incorrect1": "O = +2, S = -1",
		"incorrect2": "O = +1, S = -2",
		"incorrect3": "O = -3, S = +1"
	}, 
	
	"6" = {
		"compound": "MnO₄⁻",
		"correct": "O = -2, Mn = +7",
		"incorrect1": "O = +4, Mn = -3",
		"incorrect2": "O = -1, Mn = +6",
		"incorrect3": "O = +2, Mn = -7"
	},
	
	"7" = {
		"compound": "CO₂",
		"correct": "O = -2, C = +4",
		"incorrect1": "O = +2, C = -4",
		"incorrect2": "O = +1, C = -2",
		"incorrect3": "O = -2, C = +3"
	},
	
	"8" = {
		"compound": "C",
		"correct": "C = 0",
		"incorrect1": "C = +1",
		"incorrect2": "C = -1",
		"incorrect3": "C = +2"
	},
	
	"9" = {
		"compound": "Fe",
		"correct": "Fe = 0",
		"incorrect1": "Fe = -1",
		"incorrect2": "Fe = +2",
		"incorrect3": "Fe = +4"
	},
	
	"10" = {
		"compound": "NO",
		"correct": "O = -2, N = +2",
		"incorrect1": "O = +2, N = -2",
		"incorrect2": "O = +1, N = -2",
		"incorrect3": "O = +2, N = -1"
	},
	
	"11" = {
		"compound": "NO₂",
		"correct": "O = -2, N = +4",
		"incorrect1": "O = +2, N = -4",
		"incorrect2": "O = +2, N = -1",
		"incorrect3": "O = -2, N = +2"
	},
	
	"12" = {
		"compound": "SCl₂",
		"correct": "Cl = -1, S = +2",
		"incorrect1": "Cl = +2, S = -1",
		"incorrect2": "Cl = +1, S = -2",
		"incorrect3": "Cl = -1, S = +4"
	},
	
	"13" = {
		"compound": "H₂S₂O₇",
		"correct": "H = +1, O = -2, S = +6",
		"incorrect1": "H = +1, O = +2, S = -6",
		"incorrect2": "H = -2, O = +1, S = +6",
		"incorrect3": "H = +6, O = -2, S = +1"
	},
	
	"14" = {
		"compound": " F⁻",
		"correct": "F = -1",
		"incorrect1": "F = +1",
		"incorrect2": "F = -2",
		"incorrect3": "F = 0"
	},
	
	"15" = {
		"compound": "H₂S",
		"correct": "H = +1, S = -2",
		"incorrect1": "H = -1, S = +2",
		"incorrect2": "H = -2, S = +1",
		"incorrect3": "H = +2, S = -1"
	},
	
	"16" = {
		"compound": "CrO₄²⁻",
		"correct": "O = -2, Cr = +6",
		"incorrect1": "O = +2, Cr = +3",
		"incorrect2": "O = -3, Cr = -2",
		"incorrect3": "O = -1, Cr = +5"
	},
	
	"17" = {
		"compound": "S₈",
		"correct": "S = 0",
		"incorrect1": "S = +4",
		"incorrect2": "S = -4",
		"incorrect3": "S = +8"
	},
	
	"18" = {
		"compound": "Cu",
		"correct": "Cu = 0",
		"incorrect1": "Cu = -1",
		"incorrect2": "Cu = +2",
		"incorrect3": "Cu = +4"
	},
	
	"19" = {
		"compound": "Zn²⁺",
		"correct": "Zn = +2",
		"incorrect1": "Zn = -2",
		"incorrect2": "Zn = +1",
		"incorrect3": "Zn = 0"
	},
	
	"20" = {
		"compound": "O₂",
		"correct": "O = 0",
		"incorrect1": "O = -1",
		"incorrect2": "O = +2",
		"incorrect3": "O = -2"
	},
	
	"21" = {
		"compound": "CrCl₂",
		"correct": "Cl = -1, Cr = +2",
		"incorrect1": "Cl = +2, Cr = -1",
		"incorrect2": "Cl = -2, Cr = +4",
		"incorrect3": "Cl = -3, Cr = +1"
	},
	
	"22" = {
		"compound": "Na₂CrO₄",
		"correct": "Na = +1, O = -2, Cr = +6",
		"incorrect1": "Na = -2, O = +4, Cr = +3",
		"incorrect2": "Na = +2, O = -1, Cr = -6",
		"incorrect3": "Na = +3, O = -3, Cr = +4"
	},
	
	"23" = {
		"compound": "K₂Cr₂O₇",
		"correct": "K = +1, O = -2, Cr = +6",
		"incorrect1": "K = -2, O = +7, Cr = +2",
		"incorrect2": "K = +2, O = -1, Cr = -6",
		"incorrect3": "K = +3, O = -3, Cr = +3"
	},
	
	"24" = {
		"compound": "F₂",
		"correct": "F = 0",
		"incorrect1": "F = -2",
		"incorrect2": "F = +1",
		"incorrect3": "F = -1"
	}
}

var level3 = {
	"question1" = "Is this a redox reaction?",
	"question2" = "What reactant was oxidized?",
	"question3" = "What reactant was reduced?",
	
	"1" = {
		"chemicalEquation": "𝐶𝐻2𝑂(𝑎𝑞) + 𝑂2(𝑔) → 𝐶𝑂2(𝑔) + 𝐻2𝑂(𝑙)",
		"redox": "Yes",
		"oxidized": "CH2O",
		"reduced": "O2",
		"incorrect1": "CO2",
		"incorrect2": "H2O"
	},
	
	"2" = {
		"chemicalEquation": "2𝐾𝐶8𝐻5𝑂4 + 30𝑀𝑛2(𝑆𝑂4)3 + 24𝐻2𝑂 → 16𝐶𝑂2 + 60𝑀𝑛𝑆𝑂4 + 28𝐻2𝑆𝑂4 + 2𝐾𝐻𝑆𝑂4",
		"redox": "Yes",
		"oxidized": "KC8H5O4",
		"reduced": "Mn2(SO4)3",
		"incorrect1": "H2O",
		"incorrect2": "CO2"
	},
	
	"3" = {
		"chemicalEquation": "2𝐾𝐶8𝐻5𝑂4 + 10𝐾2𝐶𝑟2𝑂7 + 41𝐻2𝑆𝑂4 → 16𝐶𝑂2 + 46𝐻2𝑂 + 10𝐶𝑟2(𝑆𝑂4)3 + 11𝐾2𝑆𝑂4",
		"redox": "Yes",
		"oxidized": "KC8H5O4",
		"reduced": "K2Cr2O7",
		"incorrect1": "H2SO4",
		"incorrect2": "KHSO4"
	},
	
	"4" = {
		"chemicalEquation": "4𝐶𝑙−(𝑎𝑞) + 𝑂2(𝑔) + 4𝐻+(𝑎𝑞) → 2𝐻2𝑂(𝑙) + 2𝐶𝑙2(𝑔)",
		"redox": "Yes",
		"oxidized": "Cl-",
		"reduced": "O2",
		"incorrect1": "H+",
		"incorrect2": "H2O"
	},
	
	"5" = {
		"chemicalEquation": "4𝐹𝑒𝑆2(𝑠) + 15𝑂2(𝑔) + 2𝐻2𝑂(𝑙) → 𝑏𝑎𝑐𝑡𝑒𝑟𝑖𝑎 → 4𝐹𝑒3+ + 8𝑆𝑂3-4 + 4𝐻+ + 2𝐹𝑒2(𝑆𝑂4)3 + 2𝐻2𝑆𝑂4",
		"redox": "Yes",
		"oxidized": "FeS2",
		"reduced": "FeS2 and O2",
		"incorrect1": "H2O",
		"incorrect2": "Fe2(SO4)3"
	},
	
	"6" = {
		"chemicalEquation": "2𝐶𝐻2𝑂(𝑎𝑞) → 𝑏𝑎𝑐𝑡𝑒𝑟𝑖𝑎 → 𝐶𝐻4(𝑔)+ 𝐶𝑂2(𝑔)",
		"redox": "Yes",
		"oxidized": "Some of the carbon in CH2O",
		"reduced": "Some of the carbon in CH2O",
		"incorrect1": "CH4",
		"incorrect2": "CO2"
	},
	
	"7" = {
		"chemicalEquation": "𝑁2(𝑔)+ 𝑂2(𝑔) → ℎ𝑒𝑎𝑡 → 2𝑁𝑂(𝑔)",
		"redox": "Yes",
		"oxidized": "N2",
		"reduced": "O2",
		"incorrect1": "NO",
		"incorrect2": "O"
	},
	
	"8" = {
		"chemicalEquation": "2𝑁2(𝑔) + 5𝑂2(𝑔) + 2𝐻2𝑂(𝑙) → 4𝐻𝑁𝑂3(𝑎𝑞)",
		"redox": "Yes",
		"oxidized": "N2",
		"reduced": "O2",
		"incorrect1": "H2O",
		"incorrect2": "HNO3"
	},
	
	"9" = {
		"chemicalEquation": "2𝑆(𝑠) + 3𝑂2(𝑔) + 2𝐻2𝑂(𝑙) → 2𝐻2𝑆𝑂4(𝑎𝑞)",
		"redox": "Yes",
		"oxidized": "S (s)",
		"reduced": "O2",
		"incorrect1": "H2O",
		"incorrect2": "H2SO4"
	},
	
	"10" = {
		"chemicalEquation": "𝐶𝐻4(𝑔) + 2𝑂2(𝑔) → 𝐶𝑂2 + 2𝐻2𝑂",
		"redox": "Yes",
		"oxidized": "Carbon in CH4",
		"reduced": "O2",
		"incorrect1": "CO2",
		"incorrect2": "H2O"
	},
	
	"11" = {
		"chemicalEquation": "6𝐶𝑂2(𝑔) + 6𝐻2𝑂(𝑙) → 𝑐ℎ𝑙𝑜𝑟𝑜𝑝ℎ𝑦𝑙𝑙 𝑎𝑛𝑑 𝑆𝑢𝑛𝑙𝑖𝑔ℎ𝑡 → 𝐶6𝐻12𝑂6(𝑠) + 6𝑂2(𝑔)",
		"redox": "Yes",
		"oxidized": "Oxygen in CO2 and in H20",
		"reduced": "Carbon in CO2",
		"incorrect1": "C6H12O6",
		"incorrect2": "O2"
	},
	
	"12" = {
		"chemicalEquation": "2𝐻𝐶𝑙𝑂(𝑎𝑞) + 𝐹𝑒(𝑠) + 2𝐻+(𝑎𝑞) → 𝐹𝑒2+(𝑎𝑞) + 𝐶𝑙2(𝑔) + 2𝐻2𝑂(𝑙)",
		"redox": "Yes",
		"oxidized": "Fe (s)",
		"reduced": "Chlorine in HClO",
		"incorrect1": "H+",
		"incorrect2": "Fe2+"
	},
	
	"13" = {
		"chemicalEquation": "2𝐻𝐶𝑙𝑂(𝑎𝑞) + 𝑃𝑏(𝑠) + 2𝐻+ → 𝑃𝑏2+(𝑎𝑞) + 𝐶𝑙2(𝑔) + 2𝐻2𝑂",
		"redox": "Yes",
		"oxidized": "Pb (s)",
		"reduced": "Chlorine in HClO",
		"incorrect1": "H+",
		"incorrect2": "Pb2+"
	},
	
	"14" = {
		"chemicalEquation": "2𝐹𝑒2+(𝑎𝑞) + 1/2𝑂2(𝑔) + 2𝐻+(𝑎𝑞) → 2𝐹𝑒3+(𝑎𝑞) + 𝐻2𝑂(𝑙)",
		"redox": "Yes",
		"oxidized": "Fe2+",
		"reduced": "O2",
		"incorrect1": "H+",
		"incorrect2": "Fe3+"
	},
	
	"15" = {
		"chemicalEquation": "𝐶𝑑𝐶𝑙2(𝑎𝑞) + 𝑁𝑎2𝑆(𝑎𝑞) → 𝐶𝑑𝑆(𝑠) + 2𝑁𝑎𝐶𝑙(𝑎𝑞)",
		"redox": "No",
		"reaction": "This is a precipitation reaction"
	},
	
	"16" = {
		"chemicalEquation": "2𝑍𝑛𝑆(𝑠) + 2𝐻𝐶𝑙(𝑎𝑞) → 𝑍𝑛𝐶𝑙2(𝑎𝑞) + 𝐻2𝑆(𝑔)",
		"redox": "No",
		"reaction": "This is an acid-base reaction"
	}
}

var http_request: HTTPRequest
var http_request_score:HTTPRequest
var questions_data = []
var questionSet
var count = 0
var correct_answers_scene = preload("res://correct_answers.tscn")
var incorrect_answers_scene = preload("res://incorrect_answers.tscn")
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
		callback.call()
	else:
		http_request_score.connect("request_completed", callback)

func _on_score_update_complete(result, response_code, headers, body):
	if GlobalVars.levelSelected == 2 and GlobalVars.score < 70:
		get_tree().change_scene_to_file("res://game_over2.tscn")  # Change to game_over2.tscn if Level 2 is lost
	elif GlobalVars.score >= 70:
		get_tree().change_scene_to_file("res://game_win.tscn")
	else:
		get_tree().change_scene_to_file("res://game_over.tscn")

# Function to update and display the current question and answers
func updateLvl1QuestionsAnswers():
	if GlobalVars.currentHealth<=0:
		update_score_in_db("level" + str(GlobalVars.levelSelected) + "score", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		return;
	get_tree().call_group("correct", "queue_free")
	get_tree().call_group("incorrect", "queue_free")
	if count == len(questionSet) or count >= 10:
		if GlobalVars.levelSelected == 1:
			if GlobalVars.score>GlobalVars.level1score || GlobalVars.isLevel1Completed == 0:
				GlobalVars.level1score = GlobalVars.score
			# Send a request to update the score in the database
				update_score_in_db("level1score", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 2:
			if GlobalVars.score>GlobalVars.level2score || GlobalVars.isLevel2Completed == 0:
				GlobalVars.level1score = GlobalVars.score
				update_score_in_db("level2score", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		if GlobalVars.levelSelected == 3:
			if GlobalVars.score>GlobalVars.level3score || GlobalVars.isLevel3Completed == 0:
				GlobalVars.level1score = GlobalVars.score
				update_score_in_db("level3score", GlobalVars.score, Callable(self, "_on_score_update_complete"))
		await get_tree().create_timer(2.0).timeout
		if GlobalVars.levelSelected == 2:
			get_tree().change_scene_to_file("res://game_win2.tscn")  # Load game_win2.tscn if Level 2 is completed
		else:
			get_tree().change_scene_to_file("res://game_win.tscn")  # Load default win scene for other levels
		return
		return;
	# Fetch the current question and answers
	var current_question = questionSet[count] 
	count=count+1                # Fetch the question at index (count - 1)
	if GlobalVars.levelSelected == 3:
		$QuestionLabel.text = current_question["question_text"]
	else:
		$CompoundLabel.text = current_question["question_text"]
	$QuestionNum.text = "Q.No: "+str(count)+"/10"
	# Update with your column names
	# Instantiate the correct and incorrect answer scenes
	var correctAnswer = correct_answers_scene.instantiate()
	var incorrectAnswer1 = incorrect_answers_scene.instantiate()
	var incorrectAnswer2 = incorrect_answers_scene.instantiate()
	var incorrectAnswer3 = incorrect_answers_scene.instantiate()

	# Update the answer labels with the correct and incorrect answers
	correctAnswer.get_node("Label").text = current_question["correctOption"]
	incorrectAnswer1.get_node("Label").text = current_question["incorrectOption1"]
	incorrectAnswer2.get_node("Label").text = current_question["incorrectOption2"]
	incorrectAnswer3.get_node("Label").text = current_question["incorrectOption3"]
	correctAnswer.get_node("Label").self_modulate = Color(1, 1, 0)  # Red color
	incorrectAnswer1.get_node("Label").self_modulate = Color(1, 1, 0)  # Green color
	incorrectAnswer2.get_node("Label").self_modulate = Color(1, 1, 0)  # Blue color
	incorrectAnswer3.get_node("Label").self_modulate = Color(1, 1, 0)  # Yellow color
	if GlobalVars.levelSelected == 3:
		set_font_size(correctAnswer.get_node("Label"),24)
		set_font_size(incorrectAnswer1.get_node("Label"),24)
		set_font_size(incorrectAnswer2.get_node("Label"),24)
		set_font_size(incorrectAnswer3.get_node("Label"),24)
	var screen_width =1200 
	var base_y = 100 # The vertical position where the answers will be aligned
	if GlobalVars.levelSelected == 1:
		 # Width of the area where answers are to be displayed
		base_y = 100
	elif GlobalVars.levelSelected == 2:  # Width of the area where answers are to be displayed
		base_y = 150
		
		
		
	var num_answers = 4  # Total number of answers to display
	var answer_width = 150  # Estimated width of each answer node
	var total_width = num_answers * answer_width  # Total width all answers will occupy
	var start_x = (screen_width - total_width) / 2  # Start position to center the answers

	var positions = [
		Vector2((screen_width - (4 * answer_width)) / 2, base_y),  # Position 1
		Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 1, base_y),  # Position 2
		Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 2, base_y),  # Position 3
		Vector2((screen_width - (4 * answer_width)) / 2 + answer_width * 3, base_y)   # Position 4
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
	# Start fetching questions based on the selected level


# Function called when the player hits an answer
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
