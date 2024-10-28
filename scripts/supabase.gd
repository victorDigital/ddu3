extends Node

class_name Supabase

# Supabase configuration (Set your own Supabase URL and API Key)
var supabase_url: String = "https://nnsqtgnakefibqsakdwv.supabase.co/rest/v1/highscores"
var supabase_key: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5uc3F0Z25ha2VmaWJxc2FrZHd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ4NDA5NzEsImV4cCI6MjA0MDQxNjk3MX0.JqnXYZ8CaPIoWG4S4Bj3Mi3VOfZTrSvNx_I_A4HaF0k"

# Reference to HTTPRequest node
var http: HTTPRequest = null

# Initialize HTTPRequest
func _ready():
	http = HTTPRequest.new()
	add_child(http)

# Function to set headers for requests
func _set_headers() -> PackedStringArray:
	return ["Content-Type: application/json", "apikey: " + supabase_key, "Authorization: Bearer " + supabase_key]

# Function to make a POST request for user authentication (Sign Up / Sign In)
func auth_email_signup(email: String, password: String) -> void:
	var url = supabase_url + "/auth/v1/signup"
	var body = {"email": email, "password": password}
	
	var err = http.request(url, _set_headers(), HTTPClient.METHOD_POST, body)
	if err != OK:
		print("Error: Failed to make signup request: ", err)
	else:
		http.connect("request_completed", Callable(self, "_on_request_completed"))

# Function to query a table in Supabase (GET request)
func query_table(table: String, query_params: Dictionary = {}) -> void:
	var url = supabase_url + "/rest/v1/" + table + "?"
	for key in query_params.keys():
		url += key + "=" + str(query_params[key]) + "&"
	var err = http.request(url, _set_headers(), HTTPClient.METHOD_GET)
	if err != OK:
		print("Error: Failed to make query request: ", err)
	else:
		http.connect("request_completed", Callable(self, "_on_request_completed"))

# Function to insert data into a table (POST request)
func insert_into_table(table: String, data: Dictionary) -> void:
	var url = supabase_url + "/rest/v1/" + table
	var err = http.request(url, _set_headers(), HTTPClient.METHOD_POST, str(data))
	if err != OK:
		print("Error: Failed to make insert request: ", err)
	else:
		http.connect("request_completed", Callable(self, "_on_request_completed"))

# Function to handle the response from HTTPRequest
func _on_request_completed(result, response_code, headers, body):
	print("Request completed with code: ", response_code)
	var json = JSON.new()
	var response = json.parse(body.get_string_from_utf8())
	if response.error == OK:
		print("Response: ", response.result)
	else:
		print("Error: ", response.error_string)

# Example usage (replace with your actual calls in your game)
func example_usage():
	# Sign up example
	auth_email_signup("example@mail.com", "examplepassword")

	# Querying data from a "users" table
	query_table("users", {"select": "*", "limit": 10})

	# Inserting data into "users" table
	insert_into_table("users", {"username": "newuser", "email": "newuser@mail.com"})
