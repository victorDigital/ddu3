extends Node2D

var window_size
var signup_button
var login_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport().size
	_setup_buttons()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	queue_redraw()
	
func _draw():
	draw_rect(Rect2(Vector2(0,0), window_size), Color(255, 255, 255))
	
	
	
func _setup_buttons():
	signup_button = Button.new()
	signup_button.text = "Sign Up"
	signup_button.set_size(Vector2(200, 50))
	signup_button.pressed.connect(self._goto_signup)
	signup_button.set_position(Vector2((window_size.x/2-100), window_size.y/2+40))
	add_child(signup_button)
	
	login_button = Button.new()
	login_button.text = "Login"
	login_button.set_size(Vector2(200, 50))
	login_button.pressed.connect(self._goto_login)
	login_button.set_position(Vector2((window_size.x/2-100), window_size.y/2-20))
	add_child(login_button)
	
func _goto_login():
	#get_tree().change_scene_to_file("res://scenes/login_page.tscn")
	pass
	
func _goto_signup():
	get_tree().change_scene_to_file("res://scenes/signup_page.tscn")
	
	
	
