extends TextureRect
var api_key = "AIzaSyBc71qt8bE246FHgxRR3hYc0VS0U9wb8EA"
var sign_up_url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + api_key
var login_url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + api_key
var password_reset_url = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=" + api_key
var is_login_action = false
var is_password_reset = false


func _ready():
	# Check if HTTPRequest is connected
	if $HTTPRequest:
		$HTTPRequest.accept_gzip = false
		$HTTPRequest.connect("request_completed",Callable(self, "_on_http_request_request_completed"))
		print("HTTPRequest node found and signal connected.")
	else:
		$Label.text = "Unexpected error occured , please contact Dr bellamy."
		print("HTTPRequest node not found.")

# This function will be used for both login and signup actions.
func login_signup(url: String, email: String, password: String, is_login: bool):
	is_login_action = is_login
	var http = $HTTPRequest
	var jsonObj = {
		"email": email,
		"password": password,
		"returnSecureToken": true
	}
	var json = JSON.new() 
	var body = json.stringify(jsonObj) 
	var headers = ['Content-Type: application/json']
	var error = http.request(url, headers, HTTPClient.METHOD_POST, body)  # Correct usage here
	if error != OK:
		print("HTTP Request error: ", error)
	else:
		print("Request sent to: ", url)


func _on_login_button_pressed():
	$Label.text = ""
	Audio.button_hit()
	var email = $VBoxContainer/email.text
	var password = $VBoxContainer/password.text
	login_signup(login_url, email, password, true)
	
func _on_http_request_request_completed(result, response_code, headers, body):
	print("Response Code: ", response_code)
	var raw_body = body.get_string_from_utf8()
	print("Response Headers: ", headers)
	print("Raw Response Body: ", raw_body)

	var json = JSON.new()
	var error = json.parse(raw_body)
	print("error var: ",error)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", raw_body, " at line ", json.get_error_line())
		$Label.text = "Unexpected error occured , please contact Admin"
		return 
	var response = json.data

	if response_code == 200:
		if is_password_reset:
			print("Password reset successful")
			$Label.text = "Password reset email sent. Check your inbox."
			is_password_reset = false
		else:
			if typeof(response) == TYPE_DICTIONARY: 
				if response.has("idToken"): 
					var id_token = response["idToken"]
					if is_login_action:
						$Label.text = "Loading your room!"
						var http = HTTPRequest.new()
						add_child(http)
						http.connect("request_completed",Callable(self, "_on_progress_fetched"))
						var email = $VBoxContainer/email.text
						var url = "https://redoxui.onrender.com/get_user_progress/" + email
						var err = http.request(url)
						if err != OK:
							print("Error while requesting data: ", err)
						GlobalVars.userEmail = email
				else:
					print("Error: 'idToken' not found in response.")
					$Label.text = "Authentication failed. Please try again."
			else:
				print("Unexpected data structure received.")
				$Label.text = "Unexpected error occured, please contact admin."
		
	else:
		var error_message = body.get_string_from_utf8()
		print("Error: ", error_message)
		if is_password_reset:
			if raw_body.find("EMAIL_NOT_FOUND") != -1:
				$Label.text = "Email not registered. Please try again."
			else:
				$Label.text = "Error occurred during password reset. Please try again."
			is_password_reset = false
		else:
			$Label.text = "Please enter valid details."	
func _on_progress_fetched(result, response_code, headers, body):
	var json_parser = JSON.new()
	var body_string = body.get_string_from_utf8()
	if response_code == 200:
		var progress = json_parser.parse_string(body_string)
		GlobalVars.level1score = progress["Level1Score"]
		GlobalVars.level2score = progress["Level2Score"]
		GlobalVars.level3score = progress["Level3Score"]
		Audio.letsGo()
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://LvlMenu.tscn")
	else:
		$Label.text = "Try login again!"
		print(result)
		print(body_string)
		print("Failed to fetch user progress. Status Code: ", response_code)

func _on_rich_text_label_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		Audio.button_hit()
		get_tree().change_scene_to_file("res://Register.tscn")


func _on_rich_text_label_2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		Audio.button_hit()
		var email = $VBoxContainer/email.text
		if email == "":
			$Label.text = "Please enter your email to reset password."
			return
		is_password_reset = true
		send_password_reset_request(email)
		
func send_password_reset_request(email: String):
	var http = $HTTPRequest
	var jsonObj = {
		"requestType": "PASSWORD_RESET",
		"email": email
	}
	var json = JSON.new()
	var body = json.stringify(jsonObj)
	var headers = ['Content-Type: application/json']
	var error = http.request(password_reset_url, headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		print("HTTP Request error: ", error)
	else:
		print("Password reset request sent.")



