extends Control

var api_key = "AIzaSyBc71qt8bE246FHgxRR3hYc0VS0U9wb8EA"
var sign_up_url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + api_key
var register_url = "https://redoxui.onrender.com/registerGameUser"

@onready var option_button = $VBoxContainer/HBoxContainer/OptionButton 
@onready var passcode_field = $VBoxContainer/secpasscode
@onready var label = $VBoxContainer/Error   # Label to display messages or selected text
var is_password_visible = false
var is_confirm_password_visible = false

func _ready():
	$Button.connect("pressed", Callable(self, "_on_signup_button_pressed"))
	$TextureButton.connect("pressed", Callable(self, "_on_texture_button_pressed"))
	option_button.connect("item_selected", Callable(self, "_on_option_button_item_selected"))

var id_token = ""
var selected_section = ""  # Holds the selected option from the OptionButton
var FirstName  
var LastName 
var email 
var password 
var confirm_password 
func _on_signup_button_pressed():
	label.text = "Creating Your room. Kindly wait for sometime!"
	$Button.disabled = true
	$TextureButton.disabled = true
	Audio.button_hit()
	FirstName = $VBoxContainer/SID.text
	LastName = $VBoxContainer/SID2.text
	email = $VBoxContainer/Email.text
	password = $VBoxContainer/Password.text
	confirm_password = $VBoxContainer/ConfirmPassword.text
	if FirstName == "" or LastName == "" or email == "" or password == "" or confirm_password == "" or selected_section == "" or selected_section == "select your section":
		label.text = "All fields are required!"
		$Button.disabled = false  # Re-enable button for retry
		$TextureButton.disabled = false  # Re-enable button for retry
		return
	if password != confirm_password:
		label.text = "Passwords do not match!"
		return
	var httpSections = HTTPRequest.new()
	add_child(httpSections)
	httpSections.connect("request_completed",Callable(self, "_on_sectionFetched"))
	var url = "https://redoxui.onrender.com/sections/"
	var err = httpSections.request(url)
	if err != OK:
		print("Error while requesting data: ", err)

func _on_auth_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var email = $VBoxContainer/Email.text
		var firstName = $VBoxContainer/SID.text
		var lastName = $VBoxContainer/SID2.text
		var signup_data = {
			"firstName": firstName,
			"lastName": lastName,
			"email": email,
			"section": selected_section
		}
		
		var jsonDB = JSON.new()
		var bodyDB = jsonDB.stringify(signup_data)
		var http = HTTPRequest.new()
		add_child(http)
		http.connect("request_completed", Callable(self, "_on_register_response"))

		var headersDB = ["Content-Type: application/json"]
		var error = http.request(register_url, headersDB, HTTPClient.METHOD_POST, bodyDB)
		if error != OK:
			print("HTTP Request error: ", error)

		var json = JSON.new()
		var response = json.parse_string(body.get_string_from_utf8())
		id_token = response["idToken"]
		print("Firebase Signup successful! User ID: ", response["localId"])
		print("Email: ", response["email"])
	else:
		$Button.disabled = false
		$TextureButton.disabled = false
		print("Error during signup, status code: ", response_code)
		print("Response body: ", body.get_string_from_utf8())
		label.text = "Signup failed! Contact Admin"

func _on_register_response(result, response_code, headers, body):
	$Button.disabled = false
	$TextureButton.disabled = false
	if response_code == 200:
		var json_parser = JSON.new()
		var response = json_parser.parse_string(body.get_string_from_utf8())
		print("SQL Signup successful! FirstName: ", response["name"])
		label.text = "Signup successful. Hit Back Button and Login"
	else:
		print("Error during signup, status code: ", response_code)
		print("Response body: ", body.get_string_from_utf8())
		var email = $VBoxContainer/Email.text
		delete_firebase_user(email)

func delete_firebase_user(email: String):
	var delete_url = "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=" + api_key
	var request_data = {
		"idToken": id_token
	}
	
	var json = JSON.new()
	var body = json.stringify(request_data)
	var http = HTTPRequest.new()
	add_child(http)
	http.accept_gzip = false
	http.connect("request_completed", Callable(self, "_on_firebase_delete_completed"))
	http.request(delete_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)

func _on_firebase_delete_completed(result, response_code, headers, body):
	if response_code == 200:
		label.text = "SignUp Failed! Try refreshing the page and SignUp again"
	else:
		label.text = "SignUp Failed! Contact Admin"
		print("Failed to delete Firebase user, status code: ", response_code)
		print("Response body: ", body.get_string_from_utf8())

func _on_texture_button_pressed():
	Audio.button_hit()
	get_tree().change_scene_to_file("res://Auth.tscn")



func _on_option_button_item_selected(index):
	selected_section = option_button.get_item_text(index)  # Store the selected option text
	print("Selected section: ", selected_section)
	var sections_requiring_passcode = ["section 1", "section 2", "section 3", "section 4"]
	if selected_section in sections_requiring_passcode:
		passcode_field.visible = true  # Show the passcode field
	else:
		passcode_field.visible = false  # Hide the passcode field
		
func _on_sectionFetched(result, response_code, headers, body):
	var json_parser = JSON.new()
	var body_string = body.get_string_from_utf8()
	if response_code == 200:
		var codes = json_parser.parse_string(body_string)
		if typeof(codes) == TYPE_ARRAY and codes.size() > 0:
			var code = codes[0]
			if((selected_section == 'section 1' and $VBoxContainer/secpasscode.text == code["section1"]) or
				(selected_section == 'section 2' and $VBoxContainer/secpasscode.text == code["section2"]) or
				(selected_section == 'section 3' and $VBoxContainer/secpasscode.text == code["section3"]) or
				(selected_section == 'section 4' and $VBoxContainer/secpasscode.text == code["section4"]) or (selected_section == 'others')):
					var signup_data = {
					"email": email,
					"password": password,
					"returnSecureToken": true
					}
					var json = JSON.new()
					var bodyRequest = json.stringify(signup_data)
					var http = HTTPRequest.new()
					add_child(http)
					http.connect("request_completed", Callable(self, "_on_auth_request_completed"))
					var error = http.request(sign_up_url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, bodyRequest)
					if error != OK:
						print("HTTP Request error: ", error)
			else:
				$Button.disabled = false
				$TextureButton.disabled = false
				label.text = "Invalid Code. Select others if you dont have any code"
			
				


func _on_showpassword_pressed():
	is_password_visible = !is_password_visible
	$VBoxContainer/Password.secret = !is_password_visible  # Toggle the `secret` property

	# Change the TextureButton's texture based on password visibility
	if is_password_visible:
		$showpassword.texture_normal = preload("res://hide.png")
	else:
		$showpassword.texture_normal = preload("res://show.png")
		


func _on_showconfirmpassword_pressed():
	is_confirm_password_visible = !is_confirm_password_visible
	$VBoxContainer/ConfirmPassword.secret = !is_confirm_password_visible  # Toggle the `secret` property

	# Change the TextureButton's texture based on password visibility
	if is_confirm_password_visible:
		$showconfirmpassword.texture_normal = preload("res://hide.png")
	else:
		$showconfirmpassword.texture_normal = preload("res://show.png")
