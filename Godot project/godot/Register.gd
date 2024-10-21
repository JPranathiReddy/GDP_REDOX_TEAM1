extends Control

var api_key = "AIzaSyBc71qt8bE246FHgxRR3hYc0VS0U9wb8EA"
var sign_up_url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + api_key
var register_url = "https://redoxui.onrender.com/registerGameUser"
func _ready():
	$Button.connect("pressed", Callable(self, "_on_signup_button_pressed"))

func _on_signup_button_pressed():
	Audio.button_hit()
	var FirstName = $VBoxContainer/SID.text
	var LastName = $VBoxContainer/SID2.text
	var email = $VBoxContainer/Email.text
	var password = $VBoxContainer/Password.text
	var confirm_password = $VBoxContainer/ConfirmPassword.text
	var section = $VBoxContainer/HBoxContainer/Section.get_item_text($VBoxContainer/HBoxContainer/Section.selected)
	var professorName = $VBoxContainer/HBoxContainer2/Professor.get_item_text($VBoxContainer/HBoxContainer2/Professor.selected)
	if password != confirm_password:
		$VBoxContainer/Error.text = "Passwords do not match!"
		return
	var signup_data = {
			"email": email,
			"password": password,
			"returnSecureToken": true
		}
		
		
		# Convert to JSON
	var json = JSON.new()
	var body = json.stringify(signup_data)

		# Send HTTP request to Firebase Auth
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed", Callable(self,"_on_auth_request_completed"))
	var error = http.request(sign_up_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)
	
	if error != OK:
		print("HTTP Request error: ", error)	
	
func _on_auth_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var email = $VBoxContainer/Email.text
		var password = $VBoxContainer/Password.text
		var confirm_password = $VBoxContainer/ConfirmPassword.text
		var section = $VBoxContainer/HBoxContainer/Section.get_item_text($VBoxContainer/HBoxContainer/Section.selected)
		var professorName = $VBoxContainer/HBoxContainer2/Professor.get_item_text($VBoxContainer/HBoxContainer2/Professor.selected)
		var firstName = $VBoxContainer/SID.text
		var lastName = $VBoxContainer/SID2.text
		var signup_data = {
			"firstName": firstName,
			"lastName": lastName,
			"email": email,
			"section": section,
			"professorname": professorName
		}
		var jsonDB = JSON.new()
		var bodyDB = jsonDB.stringify(signup_data)
		var http = HTTPRequest.new()
		add_child(http)
		http.connect("request_completed",Callable(self, "_on_register_response"))
	
		var headersDB = ["Content-Type: application/json"]
		var error = http.request(register_url, headersDB, HTTPClient.METHOD_POST, bodyDB)
	
		if error != OK:
			print("HTTP Request error: ", error)
		var json = JSON.new()
		var response = json.parse_string(body.get_string_from_utf8())
		print("Firebase Signup successful! User ID: ", response["localId"])
		print("Email: ", response["email"])
	else:
		print("Error during signup, status code: ", response_code)	
		print("Response body: ", body.get_string_from_utf8())
		$VBoxContainer/Error. text = "Signup failed! Please contact admin"

func _on_register_response(result, response_code, headers, body):
	if response_code == 200:
		var json_parser = JSON.new()
		var response = json_parser.parse_string(body.get_string_from_utf8())
		
		print("SQL Signup successful! FirstName: ", response["name"])
		$VBoxContainer/Error.text = "Signup successful!"	
		get_tree().change_scene_to_file("res://Auth.tscn")
	else:
		print("Error during signup, status code: ", response_code)
		print("Response body: ", body.get_string_from_utf8())
		$VBoxContainer/Error.text = "Signup failed! Please contact admin"


func _on_texture_button_pressed():
	Audio.button_hit()
	get_tree().change_scene_to_file("res://Auth.tscn") # Replace with function body.
