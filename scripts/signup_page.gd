extends Node2D
var window_size
var submit_button
var email_textbox
var pwd_textbox
var supa


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport().size
	_setup_buttons()
	_setup_textboxes()
	supa = preload("res://scripts/supabase.gd").new() 
	get_tree().current_scene.add_child(supa)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
	
func _draw():
	draw_rect(Rect2(Vector2(0,0), window_size), Color(255, 255, 255))
	

func _setup_buttons():
	submit_button = Button.new()
	submit_button.text = "Submit"
	submit_button.set_size(Vector2(200, 50))
	submit_button.pressed.connect(self._sign_up)
	submit_button.set_position(Vector2((window_size.x/2-100), window_size.y/2+100))
	add_child(submit_button)
	
func _setup_textboxes():
	email_textbox = TextEdit.new()
	pwd_textbox = TextEdit.new()
	email_textbox.editable = true
	pwd_textbox.editable = true
	email_textbox.placeholder_text = "test@mail.com"
	pwd_textbox.placeholder_text = "Password"
	email_textbox.set_size(Vector2(200, 30))
	pwd_textbox.set_size(Vector2(200, 30))
	email_textbox.set_position(Vector2((window_size.x/2-100), window_size.y/2-100))
	pwd_textbox.set_position(Vector2((window_size.x/2-100), window_size.y/2-50))
	email_textbox.set_fit_content_height_enabled(true)
	pwd_textbox.set_fit_content_height_enabled(true)
	add_child(email_textbox)
	add_child(pwd_textbox)


	

func _sign_up():
	var email = email_textbox.text
	var pwd = pwd_textbox.text
	if len(pwd) >= 6:
		supa.auth_email_signup(email, pwd)
	
